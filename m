From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add color_fwrite(), a function coloring each line
 individually
Date: Sun, 11 Jan 2009 14:43:41 -0800
Message-ID: <7vwsd1o44i.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901112058570.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM93V-0002n9-It
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbZAKWny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbZAKWnx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:43:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbZAKWnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:43:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C2D018F235;
	Sun, 11 Jan 2009 17:43:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA47D8F232; Sun,
 11 Jan 2009 17:43:42 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901112058570.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 11 Jan 2009 20:59:08 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51970D3C-E031-11DD-A43E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105245>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +/*
> + * This function splits the buffer by newlines and colors the lines individually.
> + */
> +void color_fwrite(FILE *f, const char *color, size_t count, const char *buf)

Is it just me that this is grossly misnamed?  It is not about fwrite of
count bytes starting at buf in the specified color.  At list it should be
called color_fwrite_lines() or something like that.

> diff --git a/color.h b/color.h
> index 6cf5c88..9fb58f5 100644
> --- a/color.h
> +++ b/color.h
> @@ -19,5 +19,6 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
>  void color_parse(const char *var, const char *value, char *dst);
>  int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
>  int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
> +void color_fwrite(FILE *f, const char *color, size_t count, const char *buf);

Also if other functions in the family all return int to indicate errors
and name the FILE * argument fp, I find it a very bad taste not to follow
their patterns without having a good reason (which I do not see).
