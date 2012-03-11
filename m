From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 00/10] Column display
Date: Sun, 11 Mar 2012 14:02:24 +0700
Message-ID: <CACsJy8BYDtAqJwAPK4nF+KvednNS8kX3TZGa+o-_=UsapA19oA@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com> <87ehtbb5x7.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 11 08:03:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6coW-0000pX-L2
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 08:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084Ab2CKHC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 03:02:56 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64200 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2CKHCz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 03:02:55 -0400
Received: by lbbgm6 with SMTP id gm6so669683lbb.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 23:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8KOnHFfZmsuA2iAtVNNHJaZV0SwgvrOiasj8O15SEn4=;
        b=KMBtIHPwtqjFEOlDxR8bipDn4i+qDt/UK8jAU7WV9BRwkcpJj/nNcIVXGi9D/cz1La
         leRrbuG26v2rFE+mJiA2s+5qmv/n0N9qWwG2vLw8Awu39AO57c782VHfS9vXFChhDxOW
         RrtZIhO6A+kOuvrqZY6ohfsv2UyjbXezduU3YBTNnMId3feNo8vzeL2FiPE5z8LPcRPx
         VRfAJzJ3Csynqa3X7X9WVKudtMIh5JVm/ege52oCtoss35Kbv8C976J8ERaDB1fbUwjZ
         7biuRnh/Arhn9G9ZOKH7Icm/gDGfr1KI5chsHas+HL18BL7RQuztCSsZvjujcUoLF3NX
         N0Rw==
Received: by 10.152.127.9 with SMTP id nc9mr5919458lab.20.1331449374175; Sat,
 10 Mar 2012 23:02:54 -0800 (PST)
Received: by 10.112.43.227 with HTTP; Sat, 10 Mar 2012 23:02:24 -0800 (PST)
In-Reply-To: <87ehtbb5x7.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192797>

2012/3/2 Thomas Rast <trast@inf.ethz.ch>:
> I ran valgrind over the tests in pu, and I'm seeing these errors
> presumably coming from this series:
>
> t3200-branch.out:=3D=3D340=3D=3D Invalid read of size 4
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0at 0x48E676: shrink_col=
umns (column.c:101)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x48EB76: display_ta=
ble (column.c:200)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x48ED1B: print_colu=
mns (column.c:241)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x41967F: cmd_branch=
 (branch.c:793)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x40550B: run_builti=
n (git.c:308)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x4056A6: handle_int=
ernal_command (git.c:468)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x4057C0: run_argv (=
git.c:514)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x40594D: main (git.=
c:589)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0Address 0x57023ac is 0 bytes a=
fter a block of size 60 alloc'd
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0at 0x4C226FA: malloc (v=
g_replace_malloc.c:263)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x521A11: xmalloc (w=
rapper.c:35)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x48EAE8: display_ta=
ble (column.c:193)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x48ED1B: print_colu=
mns (column.c:241)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x41967F: cmd_branch=
 (branch.c:793)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x40550B: run_builti=
n (git.c:308)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x4056A6: handle_int=
ernal_command (git.c:468)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x4057C0: run_argv (=
git.c:514)
> t3200-branch.out:=3D=3D340=3D=3D =C2=A0 =C2=A0by 0x40594D: main (git.=
c:589)
>
> and very similar errors in t7004-tag.out, t9002-column.out and
> t7508-status.out. =C2=A0Can you look into it?

Thanks. There is a bug in shrink_columns() that causes invalid access.
It wil be fixed in the next reroll.
--=20
Duy
