From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Fri, 12 Jan 2007 14:11:39 -0800
Message-ID: <7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
References: <871wm08kcu.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 23:11:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ucj-0006WM-VU
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbXALWLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 17:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbXALWLn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:11:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63725 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161130AbXALWLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 17:11:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112221140.UHGO25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 17:11:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ANAo1W00p1kojtg0000000; Fri, 12 Jan 2007 17:10:49 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <871wm08kcu.fsf@morpheus.local> (David =?iso-8859-1?Q?K=E5ged?=
 =?iso-8859-1?Q?al's?= message of
	"Fri, 12 Jan 2007 14:06:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36718>

David K=E5gedal <davidk@lysator.liu.se> writes:

> The add_user_info function formats the commit as a mail message, and
> uses add_rfc2047 to format the From: line.  The add_rfc2047 assumes
> that the string is encoded as utf-8.

pretty_print_commit() labels the commit log message not just the
author name also as UTF-8 when doing plain_non_ascii.

It might make more sense to just set the log_output_encoding to
be always UTF-8 when generating an e-mail output, in
git-format-patch.

> diff --git a/utf8.h b/utf8.h
> index a07c5a8..eb64d46 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -8,7 +8,7 @@ int is_encoding_utf8(const char *name);
>  void print_wrapped_text(const char *text, int indent, int indent2, i=
nt len);
> =20
>  #ifndef NO_ICONV
> -char *reencode_string(const char *in, const char *out_encoding, cons=
t char *in_encoding);
> +char *reencode_string(const char *in, const char *out_encoding, cons=
t char *in_encoding, int *len);
>  #else
>  #define reencode_string(a,b,c) NULL
>  #endif

This feels fishy...
