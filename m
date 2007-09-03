From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix file name quoting in simplified out patch detection for --cc output
Date: Sun, 02 Sep 2007 17:22:02 -0700
Message-ID: <7vabs4oaxh.fsf@gitster.siamese.dyndns.org>
References: <200709022222.13865.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzhk-00037Y-4p
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbXICAWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXICAWH
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:22:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXICAWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:22:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C98912D0A2;
	Sun,  2 Sep 2007 20:22:26 -0400 (EDT)
In-Reply-To: <200709022222.13865.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 2 Sep 2007 22:22:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57416>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8c1e02c..5d424e5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3140,8 +3140,8 @@ sub git_patchset_body {
>  			# compact combined diff output can have some patches skipped
>  			# find which patch (using pathname of result) we are at now
>  			my $to_name;
> -			if ($patch_line =~ m!^diff --cc "?(.*)"?$!) {
> -				$to_name = $1;
> +			if ($patch_line =~ m!^diff --cc ("?.*"?)$!) {
> +				$to_name = unquote($1);
>  			}

This patch obviously makes sense, but I wonder why you use the
form m!foobar! here, instead of far simpler to read /foobar/
form?
