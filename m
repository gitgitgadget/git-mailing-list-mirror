From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 20:00:49 -0500
Message-ID: <535862411c29d_3c7abff3103e@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
 <53559b0cc066_6c39e772f09d@nysa.notmuch>
 <xmqqtx9m70fh.fsf@gitster.dls.corp.google.com>
 <53583111dd8ad_24448772ec17@nysa.notmuch>
 <xmqqvbtzwv4l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd8Ch-00039T-5E
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 03:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbaDXBLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 21:11:17 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36893 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaDXBLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 21:11:15 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so1910017obc.24
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=xreMXOyVA7sRHnqDSzPqZtbj0HiLksO7ErC8hg+HUcI=;
        b=k8vuhFjDjpyKoSONaAxBhMEu2Tbjs9wOEL3d27hiBdm38ld2Of5sg2yCZPhUC+8fAu
         WdrJUf8j+cKt1KR282YKfc0zt3pt4eo+avCEhBjDr+KyAgGA4J9TIWA/BzHVB5jS4GSF
         Vsl2rpaG1A7K8b5cWfK3b4fEEF+WNfQk0lxmkydr6UA2awmOzaRFnu4TxQ6LEA5x7G2j
         QRyCf6XG+kFyaJZCUDq2ur3+Hg0Y7nvEw6peqd4nEgZ44E4Vybj0ENgGMwzKvHEDjq56
         JD3lK7hjO36QA0upNn0cN22tGfwKcBkhZedz5o02YyHSmSq2oFvX5xJ4/YuWSEdoAFLj
         jhHA==
X-Received: by 10.60.150.143 with SMTP id ui15mr15396605oeb.50.1398301875187;
        Wed, 23 Apr 2014 18:11:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm10882076oec.0.2014.04.23.18.11.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 18:11:14 -0700 (PDT)
In-Reply-To: <xmqqvbtzwv4l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246913>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > ... there are _already_ hooks without pre/post.
> >> 
> >> Like commit-msg?  Yes, it would have been nicer if it were named
> >> verify-commit-message or something.
> >
> > No it wouldn't. I can use the commit-msg hook to change the commit message and
> > to absolutely no verification, so verify-commit-message would be misleading.
> 
> You are confused (and please do not spread the confusion).  If you
> read the first paragraph of the documentation on the hook and think
> for 5 seconds why "--no-verify" countermands it, you would realize
> that the hook is primarily meant for verification.

I do not care what the hook is "primarily for", it's for more than just
verification.

> We also allow the hook to edit the message, but that is not even "a useful
> feature added as an afterthought"; the documentation mentions it because the
> implementation did not bother to make sure the hook did not touch the message
> file.

Indeed it's too late now, and now the hook does more than just verification,
therefore verify-commit-message wouldn't be an appropriate name.

> It was a mistake not to call it with a clear name that tells
> verification happens there.

No, the name is fine for what the hook does, if you would want the script to do
something different, *and* change the name of the script, that's a different
issue.

> >> Old mistakes are harder to change because of inertia.  It is not a
> >> good excuse to knowingly make a new mistake to add new exceptions
> >> that the users need to check documentations for, is it?
> 
> I see no reason to waste more time on this point.

You haven't proved it's a mistake.

The only thing you have showed is that letting the 'commit-msg' modify the
message was a mistake, not that the name is wrong for what it currently does.

-- 
Felipe Contreras
