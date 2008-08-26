From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 20:33:05 +0200
Message-ID: <48B44C61.2020206@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <7vsksrad7o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:34:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3NA-0000zq-Eq
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbYHZSd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758485AbYHZSd0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:33:26 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:64406 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246AbYHZSdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:33:25 -0400
Received: by qb-out-0506.google.com with SMTP id a16so3408037qbd.17
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=4RNiu/SmE3834fmUAYYFPH4mnN1u+4Drzt2VcRiki04=;
        b=i/+VDp1hZgToBL3G9R4KKXHSjqFBU4GMD8kaLej2uVmfVz3hwV8OQR4gU0I7rN9snN
         OJ8BVzPXA6N1bqsl9I9+J954yaS50pFDQbN/sHODGfBQT/SJPPYRBgbxkYxnZIZwnUna
         Ee7P838Cfa0/VfS8gAZmx5oWKjSf2JZvqFI+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=cgtWMq9YKrs8ujTVLBotz4DoWxk0BrmtSuLz/UVbuALvgzOa+jIDgpWMPQJ8TXzeLo
         fCZXcpcfyteKglUGcIXrvhNWO301id1xu7kxBDnw8m3etszTr93XZscf1yzK0JgOqYLo
         KK/cmUi9HQy+6xvEB/OcufhKAuitU3HfcZOsk=
Received: by 10.86.27.9 with SMTP id a9mr4543174fga.57.1219775604347;
        Tue, 26 Aug 2008 11:33:24 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e20sm6366736fga.1.2008.08.26.11.33.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 11:33:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <7vsksrad7o.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93796>

Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Paolo Bonzini schrieb:
>>> +	/*
>>> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
>>> +	 * in die().  It also avoids not messing up when the pipes are
>>> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
>>> +	 */
>> I see your point, but I don't have an opinion whether this stretch is
>> necessary.
> 
> This is going too far.  Have you seen any other sane program that do this?

Busybox.  But it runs setuid, as Steven pointed out.

I say it's all (i.e. be this paranoid), or nothing.

Paolo
