From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Sun, 3 Oct 2010 22:50:07 -0500
Message-ID: <20101004035007.GB24884@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-2-git-send-email-newren@gmail.com>
 <7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
 <AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:53:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2c7I-0000vJ-H5
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab0JDDx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:53:28 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42150 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0JDDx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:53:27 -0400
Received: by qyk36 with SMTP id 36so2596745qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hznRw8SFEZBTKaxcBksLybJzt5SX1E4SabeQrhLrLxo=;
        b=wBlYvvVom7vBJxxNlPCD3FhzfDMu3wlzCtZSGXMLGZWnVojleumLhqfVYVjslcfUt9
         Ii2DHhRrgZhRhxsqPP5qmrKNGszCuDVQB/pXaTBGGQeEv0LeECwWAjakBHW22lU/iOEg
         LX9ciz2YkC8iRApGLAcXWz9uaevPFSYXYv3T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=x0SG3RI0BisBdWLDKw5lJ3u2yZmai8nxuEQeUV65Xs0MCPtpMA8teU4a5BBQzw/7bF
         lE1doNrMsek77HVWPFH0XUfqiaNix7nTvF+ubkJz2GILfkkrX0Fy7gKle5aDUNqotJXJ
         3XpfamBxKtqDu6g7a8B8a++WsyS4igDTOcP74=
Received: by 10.229.2.32 with SMTP id 32mr6362022qch.270.1286164401521;
        Sun, 03 Oct 2010 20:53:21 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id r36sm4907646qcs.27.2010.10.03.20.53.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 20:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157970>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> With that the output of:
>=20
>     $ rm -rfv trash*; ./t0000-basic.sh --debug; cat trash\
> directory.t0000-basic/{passing-todo,failing-cleanup}/*.sh
>=20
> Is now (cut):
>=20
>     # Point to the t/test-lib.sh, which isn't in ../ as usual
>     TEST_DIRECTORY=3D"/home/avar/g/git/t"
>     . "$TEST_DIRECTORY"/test-lib.sh

Edge case: what if the path to the git directory contains a "
character (for example because someone is trying to ensure
that git commands can cope with such a cwd)?

I suspect the best thing would be to export TEST_DIRECTORY
instead of including it inline in the script.
