Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CE1FC0F3
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523492; cv=none; b=JbNiXqgU0C18KYBz/SpQvKVZTCuB7vX1bR4CnIAL7/A0447HK9X72ny2gkGHQbbKdGI39hIfv7rz33YOXIvPiRi8tTOIRxhIDcWjJpF7qj0QIhS+17EiMGHbTyEiLMDUk0JD7w6zgos6P/aYuCtQC9oC87Ho+E1iQOm5bCdIudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523492; c=relaxed/simple;
	bh=nIEh4vl9doueGLrlmVf4feOmlb1TuvxZM63YbDDu9jo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jUPp6a7Q9ChRGGdH2Y29+shT9iKSFyT7WUUqT5TVdZO4sBNinSIS8se0WIDLwNaxDHkCLamZDK3YtPhFY9UwDUWDR+EjoVz2YsisyfR2/qZU+EhlDdv6jTXR3+uXZfX5c1LbERSv6sEH9SWcs1ptJgS+xLus5+/xp1eGtH8DY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ToOJZsou; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ToOJZsou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743523487; x=1744128287;
	i=johannes.schindelin@gmx.de;
	bh=POf2sXly7W3fHkqoJl0WQJ2OFigRt5m4ZhSyPfA5mGc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ToOJZsouo34KWhq40qciRm3H5NW3epFQkkLBrAQ40ZWdFeHe2W+eQVRaYdT6itJB
	 iDxHBcXQClng2OXcMZqqMIyOQO8p76WrzLvIzDKAxNy/T39YItykM5zCd4pI1oyM1
	 eQhvHQArjOZthKA88ZbhFvnuJnKN9qrkGzQ5Dh5c8yqQbn/qv/sS9KXaG/GNg/uz4
	 awWvFx8U2nYrbkQ08Gd1gvjCnpc1v9Gv/jv1gd6kftFEQmezxWShstKxKHapy/hIA
	 b+TcrLBk71UEMo7Fi3Lt1EOKg3PBjjH8Q60iKdTYK5eEqqMk9cKL1YD2obg2kcKBH
	 0djTtL/q+ZJVOuzfXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1tLxN21k8N-00ZkmT; Tue, 01
 Apr 2025 18:04:47 +0200
Date: Tue, 1 Apr 2025 18:04:46 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mark Levedahl <mlevedahl@gmail.com>
cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, me@yadavpratyush.com
Subject: Re: [PATCH] git-gui - simplify _open_stdout_stderr
In-Reply-To: <20230922164412.130504-1-mlevedahl@gmail.com>
Message-ID: <0140dfd8-f65d-34a0-2e66-44e3f696b100@gmx.de>
References: <20230922164412.130504-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fxWz9/Hcq+cNfOeVk/K5HYivQ5VhMnajERiGVMyhDVBO1OnvTZi
 HbdOCy8DI6wr4HHFNDWqp5jEFzFFniyNDqJpaJE+3VY3jy+XQFfkhtC4azMIL5qkyb7/nvT
 3v6yhwSvO2kQ4TFWvaPd/qmAWyTOkJwzPIybomVhTgyNQM6xObXMM/njr6FzV8oRg7Vggmd
 M/y2qtN5fkCPnHsZNeIWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jRmLcLnH/sI=;5/ZceegUcG/GvI1lLR6NFD559YQ
 Et4ZXz53c/gkM4p8xpD7CttPfVNIQPhXtjaoah5XLBph46eQdlY+9/8M2fzfj1NLJNvMf0liY
 JcLACBaPFQpTpfBBOhvQIkQ9FqFd8AA6atMiOFn4ugbaTETeyuJB51czVDYeQlQF8v/T3vxI3
 yHuShm6Yg6khwT39qFlhKagpSv0iyWF/cwG6EFeRJ51zu1VzpaMTKCxcuTC950trtDYPmeAOu
 YST4xMCiFjon6tn64LyncyVFQWt0p+jkfr9xd8Tx7ml3KEPkO/vXY71+ppw8mLIV9JAh4Flfc
 X6aykmi3KehXXb7dnQ8a2hedQ+jQM9Ovz9PKhcXk/gXs5DDUxvvX0Den8Owo//nvGV1+/3jlr
 UpzrW/x0cwr5bZ43k0PwXjPbZhRw207xetYBb0+U5zd+oWu50vC0nXHuZCHcwHbEs/goaERzW
 0srptyGLT5CIG/WQg2MDlzAdtanQ3Qpjh5EjxRajQIN2BpfQYES3MLBqTMvW2qgoNSOsshgEn
 uo9TRsndGbS0BslBYonNOC0t9VRabthjIXkFpw+0EUIS08cahBBvPl/ePXO6IfvZgNkpy/B+X
 jCjgjvKPCbixhdbTE/sDIblPVV3roVTRpsHEsUqHkRzYGxKHrtqpVlnPjE5X+zn4PQ0usbkAl
 9/t/Cj/153bTISVKsKAICsFklWMx5tDw0rT+IYCb/jbKc4NlyCVwDCWuK149XJnEUo0qVxEg7
 wh9YniFIXntHm2C6empaes3MFzRHrWSlFEXhDtqzlLJ7rrsUmNLiStmWJw9psFPDT82mGrHQ7
 VseFBrCGNuWjp3xpdjMRvTqbs2CAdtLmHsUntySMZ5HkheWdag6r1LBJUvh5Z3RdKh11XArFv
 JJlKcMj8tBv47AQd/q9/9HiLP+HRUfQr3Qo8cy3nyyRooypLUx7T2g/0xuFDAkeyMvAOkUcKi
 oHHe1G0Hm/xrjznslh5+rmuh32Ga22v+386tPZijpqBZvhWGsa7V9+PHWViRYHkO5XmoTQ7Qv
 fZBQWh8W6SlH6UjtGwtPP9MOGWGHRiPmBSs1KMszjO87aui59+PZyAJpOfYcLsrewsqB2Qe1n
 2sT8VmVLwj5KVUH98AItxr9yFgEYCZymqYvQ2hlBTOq7jtVoER67WKgBIGZswLX3uMxGFsv2v
 vK3KBEMgdqB/h4j1EUWo8EUuLH9o9+FUO+BpgxOYHGw3+FjpHUtN6BX4E5ccDy1kErgSKBCMw
 bmo3SG1OQp5GqrLmAcaVJoSvUx8/SwO+YiBTygHd8braeJNpQ39BiCkb1KrfoepQf1zZR6UFU
 25qt5A4F7ZoNzU/hLYbDvECLPVu67XRlQtiijN+CL1H0eiL/c4LR7r+n4kGHH0uyB6M/dr6iE
 BJ1idgaA4nwW0BXRcbkLKtvpFK426XWJq8EP18OFB58YtWbVY5KKpihnGzmzy63BVPcuJlbpH
 OonOiRrv7DEyv/Z1o+dAtdMfG6Y8tzjGhUmiBYbPTmastWwjv
Content-Transfer-Encoding: quoted-printable

Hi Mark,

this patch is still relevant, right? I am Cc:ing Johannes Sixt for
awareness.

Ciao,
Johannes

On Fri, 22 Sep 2023, Mark Levedahl wrote:

> From: "Mark Levedahl Date: Tue, 19 Sep 2023" <mlevedahl@gmail.com>
>
> Since b792230 ("git-gui: Show a progress meter for checking out files",
> 2007-07-08), git-gui includes a workaround for Tcl that does not support
> using 2>@1 to redirect stderr to stdout. Tcl added such support in
> 8.4.7, released in 2004, while the later 8.4.14 still predated git-gui.
> But, Cygwin was stuck on an 8.4.1 Tcl variant until 2011, hence the need
> for this workaround. Commit 7145c65 recently removed much other specific
> code for that obsolete Cygwin Tcl/Tk, but missed this piece.
>
> Also, Tcl since 8.5 explicitly supports 2>@1 across all platforms, and
> git-gui requires Tcl >=3D 8.5, further evidence the workaround is
> obsolete.  (I did test that 2>@1 works as-expected on current Linux,
> Cygwin, and Git For Windows Tcl packages).
>
> Remove the workaround and exploit concat's documented capability to
> handle both scalar and list arguments, leaving a much simpler function.
> This eliminates any question that cmd might be executed twice.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 8bc8892..a5d008d 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -583,25 +583,8 @@ proc git {args} {
>
>  proc _open_stdout_stderr {cmd} {
>  	_trace_exec $cmd
> -	if {[catch {
> -			set fd [open [concat [list | ] $cmd] r]
> -		} err]} {
> -		if {   [lindex $cmd end] eq {2>@1}
> -		    && $err eq {can not find channel named "1"}
> -			} {
> -			# Older versions of Tcl 8.4 don't have this 2>@1 IO
> -			# redirect operator.  Fallback to |& cat for those.
> -			# The command was not actually started, so its safe
> -			# to try to start it a second time.
> -			#
> -			set fd [open [concat \
> -				[list | ] \
> -				[lrange $cmd 0 end-1] \
> -				[list |& cat] \
> -				] r]
> -		} else {
> -			error $err
> -		}
> +	if {[catch {set fd [open [concat | $cmd] r]} err]} {
> +		error $err
>  	}
>  	fconfigure $fd -eofchar {}
>  	return $fd
> --
> 2.41.0.99.19
>
>
