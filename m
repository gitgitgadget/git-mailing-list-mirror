From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Wed, 30 Jun 2010 10:20:14 +0200
Message-ID: <4718B1FE-4525-41C2-A4D3-27E99C5A6973@gmail.com>
References: <20100628080234.GA7134@pvv.org> <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> <7vk4phbyl5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 10:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTsWz-00041X-3n
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 10:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab0F3IUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 04:20:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55555 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0F3IUT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 04:20:19 -0400
Received: by bwz1 with SMTP id 1so217262bwz.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=BpJXEUjVot+7mQQTof35FlI0QNXiaJe1Xlq1uecRBrM=;
        b=v9ROEZ2sOomHcCLZyc3xCLS4h9iTiQr9AW8kVLzjUPzgKIWi16UwxOVWNRMuElWHXN
         Y/SMiF244EHF8akQB6/ghW+hDkOT2t6Fsk8FqvDT0Hrpx5+zWxNGjgDEju6ZAkYSeV8B
         T8I1QoI0AzpOK6FhyOHa39D6gc6r3sBE6jCpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=ST1JFUF2ipq67eYU6j14sOZh9s5WliUen6DtnM9oTpz8S6hmEY9HbuWssM2vVE0r2Z
         9v8X4Lck0jIxSlhdbG9iXKed66V9moypjOoUw6ty8QgnYSm/YHJb2AtvkqvhGeBPLuS1
         4a9Sab7sGD2Pak7MP8UgVIlTw+UezxsvthHTU=
Received: by 10.204.115.132 with SMTP id i4mr536047bkq.129.1277886017722;
        Wed, 30 Jun 2010 01:20:17 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id bk13sm6449812bkb.4.2010.06.30.01.20.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 01:20:17 -0700 (PDT)
In-Reply-To: <7vk4phbyl5.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149952>

On 29. juni 2010, at 18.19, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

[...]

>> +If you have added attributes to a file that cause...
>> +...To prevent these unnecessary merge conflicts,
> 
> This naturally calls for an optimization idea, doesn't it?
> 
> I wonder if ll_merge should gain another flag bit to disable the calls to
> normalize_file(), so that the whole thing can be skipped when the caller
> somehow knows .gitattributes files that govern the path didn't change.
> 
> That won't be a trivial optimization and my gut feeling is that it
> shouldn't be part of this series.

Are you thinking that we could check changes in .gitattributes during a merge and only turn on normalization for those files where relevant attributes have changed?  I like it, but I agree with your gut, especially since normalization has to be enabled manually.

> I do however wonder if this should be initially introduced as an
> experimental feature, guarded with a configuration option for brave souls
> to try it out, and flip the feature on by default after we gain confidence
> in it, both in performance and in correctness.

My fix to add the configuration option to the delete/modify patch yesterday was pretty bad, sorry.  My only excuse is that I was in a hurry, I'll resend the series tonight with a better fix.
-- 
Eyvind Bernhardsen
