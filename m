From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] whatchanged: Default to DIFF_FORMAT_RAW
Date: Sun, 25 Jun 2006 04:55:04 -0700
Message-ID: <7vy7vltppj.fsf@assigned-by-dhcp.cox.net>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
	<20060625141102.b68a7cae.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 13:55:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuTCo-000152-UL
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWFYLzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWFYLzH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:55:07 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31946 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932412AbWFYLzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:55:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625115505.IJEO1341.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 07:55:05 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060625141102.b68a7cae.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Sun, 25 Jun 2006 14:11:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22618>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
> ---
>  builtin-log.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-log.c b/builtin-log.c
> index 5b3fadc..8a39770 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -28,6 +28,15 @@ static int cmd_log_wc(int argc, const ch
>  			rev->always_show_header = 0;
>  	}
>  
> +	if (!rev->diffopt.output_format && !rev->simplify_history) {
> +		/* Ugly hack!
> +		 *
> +		 * rev->simplify_history == 0 -> whatchanged
> +		 * Can't do this before setup_revisions()
> +		 */

Indeed it is ugly.  Might it be a cleaner option to signal _wc
function what command its caller is, by adding an extra
parameter (or check argv -- ugh)?
