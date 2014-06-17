From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 4/4] commit: Add commit.verbose configuration
Date: Tue, 17 Jun 2014 17:21:32 -0400
Message-ID: <20140617212132.GC13848@sigill.intra.peff.net>
References: <cover.1403033723.git.caleb@calebthompson.io>
 <2a0ed28d8ef50ce432c7680c1f01eb0f52891134.1403033723.git.caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:24:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx0rp-0007JH-Qb
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbaFQVVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:21:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:46365 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964976AbaFQVVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:21:35 -0400
Received: (qmail 28298 invoked by uid 102); 17 Jun 2014 21:21:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 16:21:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 17:21:32 -0400
Content-Disposition: inline
In-Reply-To: <2a0ed28d8ef50ce432c7680c1f01eb0f52891134.1403033723.git.caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251953>

On Tue, Jun 17, 2014 at 02:39:00PM -0500, Caleb Thompson wrote:

> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 35a4d06..471bd8f 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
>  	exec grep '^diff --git' "$1"
>  EOF
>  
> +write_script check-for-no-diff <<-'EOF'
> +	! check-for-diff
> +EOF

Don't you need "$PWD/" or similar here, since check-for-diff is not in our path?

Otherwise, your tests will always pass ("! check-for-diff" is always
true, since we cannot find it). I get (running with "-v"):

expecting success: 
        echo evenmorecontent >>file &&
        git add file &&
        test_config commit.verbose true &&
        test_set_editor "$PWD/check-for-no-diff" &&
        git commit --amend --no-verbose

/home/peff/compile/git/t/trash directory.t7507-commit-verbose/check-for-no-diff: 2: /home/peff/compile/git/t/trash directory.t7507-commit-verbose/check-for-no-diff: check-for-diff: not found

Other than that, the whole series looks OK to me.

-Peff
