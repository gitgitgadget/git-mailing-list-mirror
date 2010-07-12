From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Mon, 12 Jul 2010 05:42:54 +0000
Message-ID: <AANLkTindliEmS2XhH8B1dUyo-v-CzpLQBqZakOaNnARW@mail.gmail.com>
References: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
	<alpine.LFD.2.00.1007112327150.10598@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jul 12 07:43:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYBnL-0003IA-La
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 07:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0GLFm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 01:42:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64826 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0GLFmz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 01:42:55 -0400
Received: by iwn7 with SMTP id 7so4281914iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 22:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CBNX7uV0mdrqpmpNZr5X7WQHnhIAkJICJ3f/RBnRJ1Q=;
        b=h/a/vPF8yWbzrc3/2Hn7iFuLHsGwoOxqLSu/tHoy4HonEcPvfg3DAEEaiQUSqWgF+o
         FIA30GGYU1PHruSNzoJVO2vrKpbwfn9MI4ApVChL9rlYYDz+EMHwabQXEK+88HIQ+Yjq
         9ZLgINfEs/inAuxOsDx0ys3KsPRWG4Re7UZXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rO7jRSVG4mMm86RaTmmADQtKPa79SCmxenv3xUHqNBKaTfJ1elS2rHGnNwmPT8YidY
         WLyB3ToyyauFvTyDakYxPAo54k97PTwF67xT0rmYyAyfZs3xI5gM/pN3OxnpYoBF6ijf
         /xKVymiiINwkk3ooi4sV1yud+HT+gM+sVXWBs=
Received: by 10.231.184.16 with SMTP id ci16mr13462885ibb.23.1278913374501; 
	Sun, 11 Jul 2010 22:42:54 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 11 Jul 2010 22:42:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1007112327150.10598@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150792>

On Mon, Jul 12, 2010 at 03:32, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 11 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Is there any reason not to remove trash directories on SIGINT? It's
>> annoying that trash directories are left when I cancel a test run.
>
> What about tests that would fail due to some infinite loop? =C2=A0The=
 test
> would never complete until you manually interrupt it, and in that cas=
e
> the trash directory content might be valuable.

Unless that's due to some unreproducable heisenbug you could get the
trash directory by running the test with --debug.

> You may do 'make clean' in the test directory to clean it.

I know, but I think not cleaning them up on SIGINT is a
misfeature. These trash directories are explicitly temporary, and
should be cleaned up as the shell exists.
