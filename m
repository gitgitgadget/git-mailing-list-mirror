From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Mon, 01 Mar 2010 13:34:46 +0100
Message-ID: <4B8BB466.1000909@gnu.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org> <4B8B78BB.8050008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 01 13:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm4q9-0001hp-Jt
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 13:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab0CAMey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 07:34:54 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:39691 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab0CAMew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 07:34:52 -0500
Received: by ey-out-2122.google.com with SMTP id 25so209793eya.5
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=juvq/AVqajABBhe8GW9KY2uwcYWpn+wY2+2G/DMjo4s=;
        b=xsAUn+j7cDyV2i1L6O/KL+n+iwkWpOID5c4YBcJjcmdz98hWjSVDnkZMhDQ04N8gn1
         SnbRnwKl/3TbZuxaSdsoAaN7DOBjC/imTTryGk3nt1h6yU1PsHL3loPh1/qTmW8xV9hY
         Q44nZXL3WHk+urwqt1436MFYVpLgZk7nVkUcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xdiS8UkLY3m6jdUd7mnHXZAFaZw9HnghMIvpIiBTlI+/EybxhE4dmGlfK07qah9Pd7
         S7mmHX2Ze1OIg3W4GI+AQuRD+hMvcVomhC4WZ4wSf6qJvU1OFtbYj5aiyjQJtIX2bSPz
         7u41fRaNnE2lSJi5ogeHi5lJTQBYvlYPDDxS8=
Received: by 10.213.26.138 with SMTP id e10mr3123762ebc.80.1267446891242;
        Mon, 01 Mar 2010 04:34:51 -0800 (PST)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id 15sm2249823ewy.4.2010.03.01.04.34.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 04:34:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <4B8B78BB.8050008@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141319>

On 03/01/2010 09:20 AM, Johannes Sixt wrote:
> Christian Couder schrieb:
>> The goal of this patch series is to make it possible for "git cherry-pick"
>> to fast forward instead of creating a new commit if the cherry picked commit
>> has the same parent as the one we are cherry-picking on.
>
> Why don't you just divert to 'git merge --ff' in this case?

Because the purpose of the series is exactly to replace

   if A^ == HEAD; then
     git merge --ff A   # or git reset --hard A
   else
     git cherry-pick A
   fi

with a single "git cherry-pick --ff A".

An alternative would be the old ff-strategy series which would allow 
something like

   git merge --ff=only A || git cherry-pick A

Paolo
