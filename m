From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git gui crashes ( v 1.8.5.2)
Date: Mon, 13 Jan 2014 17:11:41 -0800
Message-ID: <20140114011141.GF18964@google.com>
References: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: =?iso-8859-1?Q?Beno=EEt_Bourbi=E9?= <benoit.bourbie@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 02:11:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2sXr-0000LX-PR
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 02:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbaANBLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 20:11:48 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:53419 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbaANBLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 20:11:45 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so2942059qaq.34
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EdBczbMKKzWGYc6hlNiGEsDycdMLNc7d5bSg3ereZVc=;
        b=Qr/pAmhM/fJOqiYS/b3BHcX6WxgHQlg5wYdx1SBHwDCLw4Wj93R++emquALWWvVnkt
         nGPBePrExLzz1SNgQLxRVdVG/uAfHVvouq0JRud1BzsIWwUildlPlxBxLXWiq/57m+hi
         Cdf9EW1rNMwlkYnmvywz2HZMOMBrdO34E4L37s8gQiVPba48h/17dPXSS8kEBEu3EKOB
         nPWTgaeIMc0AY65lBvUR6zBZqKJ0WZzF9SoRitKuFyl0dP2w0j1mxekrAUelxqNLwoJh
         OLDUcYJFiUdmjQDd2TV7Weu/q8vzfAH0UcpooVDEe1gqdHgZr3ehvjrfQvuTBayTREi3
         J6uA==
X-Received: by 10.49.48.69 with SMTP id j5mr45053988qen.71.1389661904997;
        Mon, 13 Jan 2014 17:11:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id l8sm28252575qaz.14.2014.01.13.17.11.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 17:11:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240383>

(just cc-ing some area experts)
Hi Beno=EEt,

Beno=EEt Bourbi=E9 wrote:

> git gui crashes on my Linux machin since I updated it to 1.8.5.2.

I assume you mean "master" and not 1.8.5.2, since v1.8.5.2 doesn't
include the change 918dbf58 (git-gui: right half window is paned,
2013-08-21).

> I had the message
> Error in startup script: unknown option "-stretch"
>     while executing
> ".vpane.lower paneconfigure .vpane.lower.diff -stretch always"
>     invoked from within
> "if {$use_ttk} {
> .vpane.lower pane .vpane.lower.diff -weight 1
> .vpane.lower pane .vpane.lower.commarea -weight 0
> } else {
> .vpane.lower paneconfigure..."
>     (file "git/libexec/git-core/git-gui" line 3233)
>
> So, I reverted the change that has been made in git-gui/git-gui.sh
> (Diff and Commit Area)
>
> I replaced
>
> ${NS}::panedwindow .vpane.lower -orient vertical
> ${NS}::frame .vpane.lower.commarea
> ${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height =
500
> .vpane.lower add .vpane.lower.diff
> .vpane.lower add .vpane.lower.commarea
> .vpane add .vpane.lower
>
> by
>
> ${NS}::frame .vpane.lower -height 300 -width 400
> ${NS}::frame .vpane.lower.commarea
> ${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1
> pack .vpane.lower.diff -fill both -expand 1
> pack .vpane.lower.commarea -side bottom -fill x
> .vpane add .vpane.lower
> if {!$use_ttk} {.vpane paneconfigure .vpane.lower -sticky nsew}
>
> and now, git gui works as expected.

Thanks,
Jonathan
