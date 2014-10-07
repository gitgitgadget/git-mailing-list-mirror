From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: let git grep consider sub projects
Date: Tue, 7 Oct 2014 21:12:46 +0200
Message-ID: <CAHYJk3Qrj3QfBK-MkcCS2AmyTz=AgCcruq7Df-YZKW24LMWTHg@mail.gmail.com>
References: <20141007082914.GA2729@aepfle.de>
	<xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 21:12:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbaBn-00088h-LO
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 21:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbaJGTMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 15:12:47 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:53731 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaJGTMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 15:12:47 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so4743814igi.11
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ctJ50SjgLYl7t8E6PiS5nJUjbj6DH3Im/DvPf9iDENI=;
        b=h6tQhueQTyCTvl6bZHw0TDRfKOXCCgeIy1RPQSh0ai/ngEgFDVtu3FUjkpDS0Jl1Mx
         9VcUNDV9QDpxbW0rn2uQK3KKcrutOxxK9WKIxzgaz+CtZkAyExqOU0MB2NqNRpT6RZ8l
         ALW2JSiUTHeFCyWPnPEo/XWelHuNdbBz0WrRRN1duygdT9uIq+qhfS2Xxfbh54v6QwmH
         ViBFxiN8zguUlu5l7zxhGKPVCLh27+FqCYhDA4196Nnp8wWgHzoqxhl1LkjU09Fl9fJl
         u1lQiYsXH9NXj+6ddyyVy/U992v5KZwu9MwS8eM9LzD88flJJY0fFTdxBT2KWomQj8rt
         LCcQ==
X-Received: by 10.50.87.99 with SMTP id w3mr8962604igz.4.1412709166673; Tue,
 07 Oct 2014 12:12:46 -0700 (PDT)
Received: by 10.50.178.132 with HTTP; Tue, 7 Oct 2014 12:12:46 -0700 (PDT)
In-Reply-To: <xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257946>

On 7 October 2014 20:25, Junio C Hamano <gitster@pobox.com> wrote:
> Olaf Hering <olaf@aepfle.de> writes:
>
>> How can I teach 'git grep $string' to also consider subprojects?
>>
>> The build system of xen.git clones 4 other trees into a directory in its
>> source tree during build. It would be nice if my 'git grep' searches
>> also in these cloned subdirs. Somehow there must be some knowledge
>> because 'git clean -dfx' leaves them alone, while 'git clean -dffx'
>> wipes everything.
>>
>> Olaf
>>
>> PS: Sometimes I miss a 'git clean -dfx --also-sub-repos' useful to
>> really clean everything before starting over.
>
> Is "submodule foreach" under-advertised or with less than adequate
> features?

It sounds like in these use cases, you would want the commands to run
on all the submodules but also in the parent repo, am I wrong in
thinking that git submodule foreach does only the former part? So you
would either need to make a wrapper thing yourself or run the command
twice.

In the first case with the git grep, I can also imagine that with some
nontrivial patterns, having to quote the metacharacters not only once,
but twice, can be a significant annoyance. Eg, first protect it from
git submodule foreach parsing it, and then from the shell running the
individual commands.

-- 
Mikael Magnusson
