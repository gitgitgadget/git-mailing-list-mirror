From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Tue, 01 Mar 2011 11:25:43 -0500
Message-ID: <4D6D1E07.1080109@cisco.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 17:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuSOV-0007Ij-9W
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 17:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab1CAQZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 11:25:46 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:3390 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab1CAQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 11:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1100; q=dns/txt;
  s=iport; t=1298996745; x=1300206345;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=TS+5bdmWYGFA3xs5Y9zfyrotXziQHzsyTR+v6V7BzVQ=;
  b=N7ButCjlNIlchhQ80Q80Sh83EIDi6Q5YHgSyvhzRAy7IrhjoQ4YSmDcW
   moVlfd3KjZ9xzT9KGpuWfZgdcHVm+MCnDZ+6j7bHriASCGKtW4z1Z/WTt
   f7m8iWaN5oygD4w7nqWsGIXyUFfWOPxqgLeZJKBhBcy0sg5qUetusj6in
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAEWsbE2rR7Hu/2dsb2JhbACmTHSgP5wshWEEhRKHDYNA
X-IronPort-AV: E=Sophos;i="4.62,248,1297036800"; 
   d="scan'208";a="267263601"
Received: from sj-core-5.cisco.com ([171.71.177.238])
  by sj-iport-4.cisco.com with ESMTP; 01 Mar 2011 16:25:45 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id p21GPi60004817;
	Tue, 1 Mar 2011 16:25:44 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168228>

On 03/01/2011 09:50 AM, Junio C Hamano wrote:
> The reason I am skeptical about the "from root prefix" is because I do not
> see a way to make it compatible with other meaningful pathspecs.
>
>     $ cd Documentation
>     $ git grep -e frotz '*.txt'
>
> would find frotz in all *.txt files in Documentation (and its
> subdirectories), if the command takes "relatigve to cwd".
>
> It also is very clear that
>
>     $ cd Documentation
>     $ git grep --full-tree -e frotz '*.txt'
>
> would find those anywhere, inside or outside Documentation.
>
> On the other hand, it is natural to expect that
>
>     $ git grep -e frotz ".../*.txt"
>
> should find *.txt files _only_ at the root level, so it is not as
useful as
> the --full-tree (or --root).

I don't understand this last statement.  I think it implies that it is
also natural to expect that

    $ git grep -e frotz -- "../*.txt"

should find *.txt files _only_ in the parent directory.  But this is not
the case.  It returns the same search results as

    $ ( cd .. ; git grep -e frotz -- "*.txt" )

Phil
