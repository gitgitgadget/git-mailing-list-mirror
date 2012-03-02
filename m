From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v7 00/10] Column display
Date: Fri, 2 Mar 2012 12:25:56 +0100
Message-ID: <87ehtbb5x7.fsf@thomas.inf.ethz.ch>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
	<1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Qch-0000ih-26
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955Ab2CBL0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 06:26:01 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:2350 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964792Ab2CBL0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 06:26:00 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:25:55 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:25:57 +0100
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28
 Feb 2012 18:58:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192030>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
>   Add git-column for columnar display
>   Stop starting pager recursively
>   column: add columnar layout
>   column: add dense layout support
>   column: add column.ui for default column output settings
>   help: reuse print_columns() for help -a
>   branch: add --column
>   status: add --column
>   column: support piping stdout to external git-column process
>   tag: add --column

I ran valgrind over the tests in pu, and I'm seeing these errors
presumably coming from this series:

t3200-branch.out:=3D=3D340=3D=3D Invalid read of size 4
t3200-branch.out:=3D=3D340=3D=3D    at 0x48E676: shrink_columns (column=
=2Ec:101)
t3200-branch.out:=3D=3D340=3D=3D    by 0x48EB76: display_table (column.=
c:200)
t3200-branch.out:=3D=3D340=3D=3D    by 0x48ED1B: print_columns (column.=
c:241)
t3200-branch.out:=3D=3D340=3D=3D    by 0x41967F: cmd_branch (branch.c:7=
93)
t3200-branch.out:=3D=3D340=3D=3D    by 0x40550B: run_builtin (git.c:308=
)
t3200-branch.out:=3D=3D340=3D=3D    by 0x4056A6: handle_internal_comman=
d (git.c:468)
t3200-branch.out:=3D=3D340=3D=3D    by 0x4057C0: run_argv (git.c:514)
t3200-branch.out:=3D=3D340=3D=3D    by 0x40594D: main (git.c:589)
t3200-branch.out:=3D=3D340=3D=3D  Address 0x57023ac is 0 bytes after a =
block of size 60 alloc'd
t3200-branch.out:=3D=3D340=3D=3D    at 0x4C226FA: malloc (vg_replace_ma=
lloc.c:263)
t3200-branch.out:=3D=3D340=3D=3D    by 0x521A11: xmalloc (wrapper.c:35)
t3200-branch.out:=3D=3D340=3D=3D    by 0x48EAE8: display_table (column.=
c:193)
t3200-branch.out:=3D=3D340=3D=3D    by 0x48ED1B: print_columns (column.=
c:241)
t3200-branch.out:=3D=3D340=3D=3D    by 0x41967F: cmd_branch (branch.c:7=
93)
t3200-branch.out:=3D=3D340=3D=3D    by 0x40550B: run_builtin (git.c:308=
)
t3200-branch.out:=3D=3D340=3D=3D    by 0x4056A6: handle_internal_comman=
d (git.c:468)
t3200-branch.out:=3D=3D340=3D=3D    by 0x4057C0: run_argv (git.c:514)
t3200-branch.out:=3D=3D340=3D=3D    by 0x40594D: main (git.c:589)

and very similar errors in t7004-tag.out, t9002-column.out and
t7508-status.out.  Can you look into it?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
