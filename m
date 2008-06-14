From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] fix whitespace violations in test scripts
Date: Sat, 14 Jun 2008 00:20:45 -0700
Message-ID: <7v1w30iisy.fsf@gitster.siamese.dyndns.org>
References: <20080614064857.GA8930@sigill.intra.peff.net>
 <20080614065119.GA9006@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Q5M-0006Mi-Tm
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbYFNHVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYFNHVF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:21:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbYFNHVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:21:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 898753E95;
	Sat, 14 Jun 2008 03:21:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B4A333E94; Sat, 14 Jun 2008 03:20:54 -0400 (EDT)
In-Reply-To: <20080614065119.GA9006@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 14 Jun 2008 02:51:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7099E880-39E2-11DD-A92E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84975>

Jeff King <peff@peff.net> writes:

> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> index d24a47d..7cdd70a 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -5,7 +5,7 @@ test_description='test git rev-parse --parseopt'
>  
>  cat > expect.err <<EOF
>  usage: some-command [options] <args>...
> -    
> +
>      some-command does foo and bar!
>  
>      -h, --help            show the help

This part unfortunately falls into the same category as your [3/4].

---

 parse-options.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index acf3fe3..5e56bb5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -312,8 +312,12 @@ void usage_with_options_internal(const char * const *usagestr,
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
 		fprintf(stderr, "   or: %s\n", *usagestr++);
-	while (*usagestr)
-		fprintf(stderr, "    %s\n", *usagestr++);
+	while (*usagestr) {
+		if (**usagestr)
+			fprintf(stderr, "    %s", *usagestr);
+		putc('\n', stderr);
+		usagestr++;
+	}
 
 	if (opts->type != OPTION_GROUP)
 		fputc('\n', stderr);
