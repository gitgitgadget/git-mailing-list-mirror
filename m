From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 12:10:00 +0100
Message-ID: <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com>
References: <20071217095014.GF7453@artemis.madism.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4DsE-0007lp-St
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935522AbXLQLKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 06:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935571AbXLQLKT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:10:19 -0500
Received: from wincent.com ([72.3.236.74]:57961 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934343AbXLQLKS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 06:10:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHBA1ck019120;
	Mon, 17 Dec 2007 05:10:02 -0600
In-Reply-To: <20071217095014.GF7453@artemis.madism.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68542>

El 17/12/2007, a las 10:50, Pierre Habouzit escribi=F3:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>>    // ...
>>    /* when in `git --opt1 --opt2 foo -a -b -c` mode: */
>>    int cmd_pos =3D git_find_builtin_command_name(argc, argv);
>>    int count =3D parse_options(cmd_pos, argv, git_generic_options,
>> 	"git [special-options] cmd [options]", 0);
>>    if (count)
>> 	die("unknown git command: `%s`", argv[0]);
>>    argv +=3D cmd_pos;
>>    argc -=3D cmd_pos;
>>    /* here we simulate an argv of {"foo", "-a", "-b", "-c"} */
>
>    Or even simpler, with the following specifically tailored patch yo=
u
>    can directly write:
>
>    argc =3D parse_options(argc, argv, git_generic_options,
> 	"git [generic-options] <command> [cmd-options]",
> 	PARSE_OPT_STOP_AT_ARG);
>
>    and then {argc, argv} will exactly be the NULL-terminated array
>    starting with the builtin command. Kind of nice :)

Indeed, nice ideas. I think all this will lead to a nice UI =20
improvement post-1.5.4.

About the only thing that I think would merit action *prior* to 1.5.4 =20
is marking the "-p" switch to git (synonym for --paginate) as =20
deprecated, see as it clashes with other commands' uses of that switch =
=20
("git log -p" for example). Are there any other conflicting specials =20
that a currently parsed in git.c?

Cheers,
Wincent
