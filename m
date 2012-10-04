From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --amen
Date: Thu, 04 Oct 2012 10:13:49 -0700
Message-ID: <7v1uhe17oy.fsf@alter.siamese.dyndns.org>
References: <0d559e3191a392841124d96870a67735@rom1v.com>
 <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
 <7va9w218ou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Romain_Vimont_=28=C2=AEom=29?= <rom@rom1v.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJte6-00033L-3n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab2JDRNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 13:13:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab2JDRNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 13:13:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1A1932E;
	Thu,  4 Oct 2012 13:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+NRJXSQaj18B4XLa4jdHBFOsP8E=; b=Pnn8YH
	ABOE3gPelVOqShoMFI1+IPn0IAl2bmSbeq6uAavv3bXmraZ+s8gJMj+TyNRCJhQf
	SeDbqgN5vMxyQ6L1uQV6yliDyocORGG0ppRmgECY15c0LEOLN+yFi94hC7v3g32p
	tyWNBFrwI0zKCF3oulLgW4S3DKPTiJDknxR4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WAQBgKpC+9zk2FmrwLfUuCWKm4fHhSJs
	ygr3UVcsTbxjG6500MuR+6TYQPzPSsS+GquOOojm9/IreYMHrOPZFZI9pT5LSKoJ
	dTl8AIbbYQPM4yXN3aEqhQQuD1UtEo9+8N9DTd1fWBOcm1FoVxlT5ObtsLmu//vE
	LZwZIVCXoo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AD99932C;
	Thu,  4 Oct 2012 13:13:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73F019328; Thu,  4 Oct 2012
 13:13:50 -0400 (EDT)
In-Reply-To: <7va9w218ou.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Oct 2012 09:52:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDB78A98-0E46-11E2-BD7D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207030>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>>> Is it normal that "git commit --amen" actually works ?
>>> (it does like --amend)
>>>
>>> version 1.7.10.4
>>
>> Yes.  From Documentation/technical/api-parse-options.txt:
>>
>>     * Long options may be 'abbreviated', as long as the abbreviation
>>       is unambiguous.
>>
>> Apparently since 2008-06-22.
>
> Notice "technical/api-" part; that is a _wrong_ documentation page
> to quote to end users.
>
> Instead quote from "git help cli".
>
>        From the git 1.5.4 series and further, many git commands (not
>        all of them at the time of the writing though) come with an
>        enhanced option parser.
>
>> So 'git commit --am' also works.  But it should probably be avoided
>> because of its similarity to 'git commit -am'.
>
> Yes, in general, you should avoid relying on shortened form
> working.  Git 2.4 may add an option "--amen" that has totally
> different meaning.

Perhaps a patch along this line might not hurt.

 Documentation/gitcli.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git i/Documentation/gitcli.txt w/Documentation/gitcli.txt
index f6ba90c..3bc1500 100644
--- i/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -93,7 +93,7 @@ ENHANCED OPTION PARSER
 From the git 1.5.4 series and further, many git commands (not all of them at the
 time of the writing though) come with an enhanced option parser.
 
-Here is an exhaustive list of the facilities provided by this option parser.
+Here is a list of the facilities provided by this option parser.
 
 
 Magic Options
@@ -137,6 +137,16 @@ options. This means that you can for example use `git rm -rf` or
 `git clean -fdx`.
 
 
+Abbreviating long options
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Commands that support the enhanced option parser accepts unique
+prefix of a long option as if it is fully spelled out, but use this
+with a caution.  For example, `git commit --amen` behaves as if you
+typed `git commit --amend`, but that is true only until a later version
+of Git introduces another option that shares the same prefix,
+e.g `git commit --amenity" option.
+
+
 Separating argument from the option
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You can write the mandatory option parameter to an option as a separate
