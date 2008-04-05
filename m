From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [REGRESSION] git-gui
Date: Sat, 5 Apr 2008 00:01:06 -0400
Message-ID: <20080405040106.GW10274@spearce.org>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <20080404012723.GL10274@spearce.org> <200804042304.42794.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Jonathan del Strother <maillist@steelskies.com>,
	=?utf-8?B?QW5kcsOp?= Goddard Rosa <andre_rosa@lge.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 06:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhzbQ-0006CW-7v
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 06:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYDEEBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 00:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbYDEEBN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 00:01:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53492 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYDEEBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 00:01:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JhzaW-0007Cd-5O; Sat, 05 Apr 2008 00:01:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4988B20FBAE; Sat,  5 Apr 2008 00:01:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200804042304.42794.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78837>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> 
> So, it doesn't recognize [ at all at the keysym (%K) level.
> No idea why. This is Tcl/Tk 8.4.15 on Linux.
...
> ctrl-+ and ctrl-=	-> more context
> ctrl--			-> less context

This is reasonable.  I like.
 
>  	.mbar.commit add command -label [mc "Show Less Context"] \
>  		-command show_less_context \
> -		-accelerator $M1T-\[
> +		-accelerator $M1T-\-
>  
>  	.mbar.commit add command -label [mc "Show More Context"] \
>  		-command show_more_context \
> -		-accelerator $M1T-\]
> +		-accelerator "$M1T-+ $M1T-="

Sadly Mac OS X does not like this accelerator in the menu.
It drops the accelerator entirely and just shows nothing.
I changed it to show "$M1T-=", but kept the bindings as
you had them below, so $M1T-+ is an alias.
  
> @@ -2715,8 +2715,11 @@ bind $ui_comm <$M1B-Key-v> {tk_textPaste %W; %W see insert; break}
>  bind $ui_comm <$M1B-Key-V> {tk_textPaste %W; %W see insert; break}
>  bind $ui_comm <$M1B-Key-a> {%W tag add sel 0.0 end;break}
>  bind $ui_comm <$M1B-Key-A> {%W tag add sel 0.0 end;break}
> -bind $ui_comm <$M1B-Key-bracketleft> {show_less_context;break}
> -bind $ui_comm <$M1B-Key-bracketright> {show_more_context;break}
> +bind $ui_comm <$M1B-Key-minus> {show_less_context;break}
> +bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_context;break}
> +bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
> +bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
> +bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
>  
>  bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
>  bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
> @@ -2760,8 +2763,11 @@ bind .   <$M1B-Key-t> do_add_selection
>  bind .   <$M1B-Key-T> do_add_selection
>  bind .   <$M1B-Key-i> do_add_all
>  bind .   <$M1B-Key-I> do_add_all
> -bind .   <$M1B-Key-bracketleft> {show_less_context;break}
> -bind .   <$M1B-Key-bracketright> {show_more_context;break}
> +bind .   <$M1B-Key-minus> {show_less_context;break}
> +bind .   <$M1B-Key-KP_Subtract> {show_less_context;break}
> +bind .   <$M1B-Key-equal> {show_more_context;break}
> +bind .   <$M1B-Key-plus> {show_more_context;break}
> +bind .   <$M1B-Key-KP_Add> {show_more_context;break}
>  bind .   <$M1B-Key-Return> do_commit
>  foreach i [list $ui_index $ui_workdir] {
>  	bind $i <Button-1>       "toggle_or_diff         $i %x %y; break"
> -- 
> 1.5.4.5
> 

-- 
Shawn.
