From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sat, 25 Aug 2007 23:36:43 -0700
Message-ID: <C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com><7v1wdqud0z.fsf@gitster.siamese.dyndns.org><52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com> <7vsl66svv4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 08:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPBkQ-0004kP-Bq
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 08:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbXHZGgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 02:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbXHZGgs
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 02:36:48 -0400
Received: from ag-out-0708.google.com ([72.14.246.240]:4191 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbXHZGgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 02:36:47 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2243358aga
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 23:36:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=fpY233huMYZIYhvZMbsba1UpuPoO5wsWOvszXhgm9be8qzWRYVp8nDbr5kKAn0CvYHblqq8K855CgY4+elNZjLjeEJnQCf0AOR/xm0SrUn2PGiKbnJDQUag5THYtB/mQzEEr+2Z1FJHWdLq3yaWdAtDvfxJSpZpGh9AtjkeRIrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=K71s3tAwW7Ec0w9BvdCzmRYVaQhStonDXvCAyWixGmp8G7QHixQvoZaEDWDSmgGp3npXzrmB6n1J4IhQOvq0n+GJQ5dJZmxQhx8EgF8q0dgYKocncge91gg51ha73lr4XdgU1g1OaveyWlqoJ8XS04U7w3DxGKin4OY7Kh73+lI=
Received: by 10.114.126.1 with SMTP id y1mr1067636wac.1188110205870;
        Sat, 25 Aug 2007 23:36:45 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id j39sm5262179waf.2007.08.25.23.36.45
        (version=SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 23:36:45 -0700 (PDT)
In-Reply-To: <7vsl66svv4.fsf@gitster.siamese.dyndns.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56676>

----- Original Message ----- 
From: "Junio C Hamano" <gitster@pobox.com>
>> Can you specify _exactly_ how it works now? And I'll show you a bunch of corner cases where it's broken.
>
> As I made it clear, it is a compromise.  I am not interested in
> discussing corner cases with you -- I am sure there are.

Usually many corner cases == design flaw.

> If you are offering improvements, I am all ears.

I thought I did: I've observed that these problem are caused by storing metadata in regular files (that exist both in repo/index and 
in workplace).
My knowledge of Git internals is quite limited, but if *I* were to do it right now, I'd introduce a META entry in every TREE object 
that would point to a BLOB that contains combined content of .gitattributes, .gitignore etc. Then command like 'git meta' would open 
vi for this BLOB, let you edit it, and then would upload it back to index.

- Dmitry
