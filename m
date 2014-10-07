From: Julien Carsique <julien.carsique@gmail.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 07 Oct 2014 17:57:23 +0200
Message-ID: <54340D63.8030507@gmail.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>	<542B1623.2070109@bbn.com>	<xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>	<542B7AF8.6080501@bbn.com> <xmqqppebptmj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?windows-1252?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 17:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbX8o-0001Bo-V7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 17:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbaJGP5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 11:57:30 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:62964 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaJGP50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 11:57:26 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so8338186wiv.14
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KH79xUxgEYQUjc+MBAS1msoEsAr997U0bFrsPp2aNDY=;
        b=cvJXZ6W20Y25QDws4UmVhCSJMM2zP1U6woi/fh748x9pflQFojUz2oLciECjQqAXGI
         11NhKNFjK7QQ3slPwxSnhV5qbwWACq7lXVnAoRTtxa2kILtwcG2XcosSoxp9L8+DSAli
         PaI/yvyZpV//dDMPXQOw7lisfzg0JAQ/id3focM9CSw+LXdDY0rL2FFzpzOZl587DJcG
         5diUGUbbX4Gszx799SYleBPlLqZ+ldGBkivyGrX/grvxi7kGzxd5PdxFnG/E5zx8Jidk
         zjmasjRXuJh2bvRFnYAk9fDsZJqMpi0fQGpJQ/DllMzdXU9KVatX2t3FaMyYlxYXHjnS
         eKiw==
X-Received: by 10.194.120.37 with SMTP id kz5mr6052463wjb.107.1412697444732;
        Tue, 07 Oct 2014 08:57:24 -0700 (PDT)
Received: from [10.213.2.104] ([176.57.246.10])
        by mx.google.com with ESMTPSA id p1sm21238938wjy.22.2014.10.07.08.57.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 08:57:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqppebptmj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257929>

Hi,

Thank you both for your feedback!
I'm looking at applying your requests:
- add tests,
- variable renaming,
- use of local,
- fix multiple issues on string parsing
- avoid useless bash-isms? Did you agree on the ones I should remove?

I'll send an updated patch asap. Tell me if I forgot something.

Regards,
Julien

On 01/10/2014 19:49, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
>
>>> and there is no hope to "fix" them to stick to
>>> the bare-minimum POSIX,
>> I don't think it'd be hard to convert it to pure POSIX if there was a
>> desire to do so.
> Not necessarily; if you make it so slow to be usable as a prompt
> script, that is not a "conversion".  Bash-isms in the script is
> allowed for a reason, unfortunately.
>
>> It would be unwise to go to great lengths to avoid Bashisms, but I think
>> it would be smart to use POSIX syntax when it is easy to do so.  
> In general, I agree with you. People who know only bash tend to
> overuse bash-isms where they are not necessary, leaving an
> unreadable mess.
>
> For the specific purpose of Julien's "if the tail part of this
> string matches the other string, replace that with an equal sign",
> ${parameter/pattern/string} is a wrong bash-ism to use.  But the
> right solution to count the length of the other string and take a
> substring of this string from its beginning would require other
> bash-isms ${#parameter} and ${parameter:offset:length}.
>
> And that's fine.
