Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69ADE1F453
	for <e@80x24.org>; Thu,  2 May 2019 07:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEBHtJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 03:49:09 -0400
Received: from [195.159.176.226] ([195.159.176.226]:40924 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 03:49:09 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1hM6Sp-000icY-NA
        for git@vger.kernel.org; Thu, 02 May 2019 09:49:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH v4 1/1] git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Thu, 02 May 2019 09:48:58 +0200
Organization: Linux Private Site
Message-ID: <87sgtxi9ed.fsf@Rainer.invalid>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181215043330.20162-1-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Cancel-Lock: sha1:J8MKDDWmxJnXwbllpJREPNQEU8M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Trying to revive that discussion]

tboegi@web.de writes:
> The cygwin layer "knows" that "C:\cygwin" is an absolute path,
> but the new string operation does not.

Then use the Cygwin API to produce the corresponding POSIX path and use
that.  Also, why does Git not use POSIX realpath on systems where it's
available?

> "git clone <url> C:\cygwin\home\USER\repo" fails like this:
> fatal: Invalid path '/home/USER/repo/C:\cygwin\home\USER\repo'
>
> The solution is to implement has_dos_drive_prefix(), skip_dos_drive_prefix()
> is_dir_sep(), offset_1st_component() and convert_slashes() for cygwin
> in the same way as it is done in 'Git for Windows' in compat/mingw.[ch]

No.  I don't care what MinGW does, but keep these heuristics out of Cygwin.

> Extract the needed code into compat/win32/path-utils.[ch] and use it
> for cygwin as well.

Can you please remove that Win32 stuff from Cygwin again?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

DIY Stuff:
http://Synth.Stromeko.net/DIY.html

