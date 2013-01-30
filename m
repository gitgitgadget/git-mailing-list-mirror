From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/3] fixup! mergetool--lib: add functions for finding
 available tools
Date: Wed, 30 Jan 2013 20:34:39 +0000
Message-ID: <20130130203439.GO1342@serenity.lan>
References: <cover.1359575447.git.john@keeping.me.uk>
 <2c7dec096455e6e43d2e9aa28668f69a26f3d5f9.1359575447.git.john@keeping.me.uk>
 <7vk3quju7t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:35:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0eNB-00062o-EE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab3A3Uer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:34:47 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:53723 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3A3Ueq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:34:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 0F5AD1980BE;
	Wed, 30 Jan 2013 20:34:46 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2GIoiTTfFtx; Wed, 30 Jan 2013 20:34:45 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 88CD9198052;
	Wed, 30 Jan 2013 20:34:41 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vk3quju7t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215073>

On Wed, Jan 30, 2013 at 12:23:34PM -0800, Junio C Hamano wrote:
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index 25631cd..b6ed2fa 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -34,9 +34,9 @@ show_tool_names () {
> >  				then
> >  					echo "$preamble"
> >  					preamble=
> > -					shown_any=yes
> >  				fi
> > -				printf "%s%s\n" "$per_line_prefix" "$tool"
> > +				shown_any=yes
> > +				printf "%s%s\n" "$per_line_prefix" "$toolname"
> 
> Thanks for spotting s/tool/toolname/; does the change to shown_any
> matter, though?

Not really since we don't call it with an empty "$preamble" but if
something ever did then this ensures that shown_any is set correctly.

The $tool -> $toolname doesn't really matter either since setup_tool
sets it as a global variable, but I'd rather not rely on that.

> >  			fi
> >  		done
> >  		test -n "$shown_any"
> > @@ -244,6 +244,7 @@ show_tool_help () {
> >  
> >  	tab='	' av_shown= unav_shown=
> >  
> > +	cmd_name=${TOOL_MODE}tool
> >  	if show_tool_names 'mode_ok && is_available' "$tab$tab" \
> >  		"$tool_opt may be set to one of the following:"
> >  	then
