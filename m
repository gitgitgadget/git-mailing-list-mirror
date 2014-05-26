From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 5/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 13:33:04 -0700
Message-ID: <20140526203304.GA11888@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
 <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 22:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp1a7-00035S-TX
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 22:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbaEZUdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 16:33:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38547 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaEZUdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 16:33:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so8137573pbb.33
        for <git@vger.kernel.org>; Mon, 26 May 2014 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=m6XvuJL0dCgmU8hrmhjiTprwkLUFzrgURa6DGGmFa1U=;
        b=0HxOTnnXq3M8zVjyBuHGxudMwbYx9L+Q/W9ktOC+3pzAw8QO8MzlHcUN78i/tDuk21
         Qa6hEHPfQKPgTOUZl2I0MF4zWw7zw0MtvtP0h/B9fzQWhZU2HI1r6DUx1xVmNTjtDBBC
         1PVuAGa9MOTdPIja8azS6b1Zc2k5zUfQ6SNWNhtKSf44D9ZcBz0E0RmX7Afw7UNqHvbd
         aRkaQ5gXz4Pqd26ANfi6L0Aj7iwxLJA6cJJCOEXt7GVUXo18L4gwc+p/W5ZrRy3OeBYR
         J/P8kD9n+W8N8RG6L/XpJm0etPg9DLrYMXMHD5HxU3qMP9NHj6Ox/Vvijarh/uJvQBT8
         ZNqA==
X-Received: by 10.66.184.175 with SMTP id ev15mr11850107pac.146.1401136389093;
        Mon, 26 May 2014 13:33:09 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id rc3sm19710139pbc.5.2014.05.26.13.33.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 13:33:07 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 13:33:04 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250121>

j
On Mon, May 26, 2014 at 01:56:26PM -0500, Caleb Thompson wrote:
> Add a new configuration variable commit.verbose to implicitly pass
>  
...
> +test_expect_success 'commit shows verbose diff with set commit.verbose=true' '
> +	echo morecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$(pwd)/check-for-diff" &&
> +	git commit --amend
> +'
> +
> +test_expect_success 'commit --verbose overrides verbose=false' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose false  &&
> +	test_set_editor "$(pwd)/check-for-diff" &&
> +	git commit --amend --verbose
> +'
> +
> +test_expect_success 'commit does not show verbose diff with commit.verbose=false' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose false &&
> +	test_set_editor "$(pwd)/check-for-no-diff" &&
> +	git commit --amend
> +'
> +
> +test_expect_success 'commit --no-verbose overrides commit.verbose=true' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$(pwd)/check-for-no-diff" &&
> +	git commit --amend --no-verbose
> +'
> +
...
> 

It appears that these tests still aren't checking to see if the
"verbose" output appears in the commit message.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
