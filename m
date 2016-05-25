From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 2/3] bisect: rewrite `check_term_format` shell function
 in C
Date: Wed, 25 May 2016 07:04:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605250657250.4449@virtualbox>
References: <20160524072124.2945-1-pranit.bauva@gmail.com> <20160524072124.2945-3-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 07:05:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5R0a-00028v-M5
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 07:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbcEYFFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 01:05:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:55662 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbcEYFFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 01:05:20 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MKYsh-1b4c3j0S6Z-001wcm; Wed, 25 May 2016 07:05:12
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160524072124.2945-3-pranit.bauva@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:a0bg1z3BfuvCsm/MBq0uJH2zauWUaQWoNCjsrz71Y1K1L4LSlm1
 JapLyC9Y9jqy3PSX/0iCKT7yksfBvzxT7V1CqqXhpdueKXBSKDjbvYD554o8+YiwurrXsju
 JRhRKEk1ba9XgnrZAYf2KfrRPkjHFBZ8q8hauix6fxrmEPNEEYsa53O6vy44NB7WEEpoqgL
 zYhFeoRrSiyYsXvUnvn9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YfYsBJrVkwY=:PSz4BkSZQ+hziSU7/fuEKy
 T/lZYRq9l/boePurQTSe3n7VA9nkzd1uN0mkvKWtLjpt4Kd/p3JdCFZjX/TAmGVaqs5p6R57Z
 ipOC5nCb4A1qshefQA9ctx8KP6FOkCuJGtnyTVmG3hT/jE3rJNxaoH31Rv9pSM8/1ysm5QkGr
 XXbHqSY/aHbV9X4Lf9v1H52ya1k4DS8wqol+ikLj3v7yOS287l0DnhcVwHrnFPJBuvZssVGbp
 jyrHa7WGhOACIL60pbFq06/UQ6Y2Ius8IRP94LfQeZGfjk+J7CLlmLRZrmuSoqr9M/Er14fGW
 ASZ/fTe6PwzZw7YL/6OcEQBerkR7BvKxVvhGKKZyRn3CLz8MMkzvaHaW/RMU7mntezqF7ENeA
 SjSwPV+x+nOlDCEE6NjDnbWrFrYqRf/sIM7QD37XULXWp8umZZhsZfupeX0hZgqciz1pv3g3o
 +b5sjpB6IoMMY4kfeItbUpXIrcuAIuAqKnklChFQ0T0qvviiMGgRpU6oo4DeSL4fbk1UjpM8w
 LE1ht4bRmcX2qoIiP4fbjlD/TPSaym3uZq/peP9DzktyVnRNmYtKC6HmMJBI2tLoywIWpd131
 SbFsfncOpIXVN0tLbM4eNAtJNi6c+MG004TPQNrWNGol/t/i1TNZOCZ6qdNa5K52jOO4cy5Cb
 d90yc+mitv66DNhdHbKgNB67DZEngsawBeIb5KqM7nkBL6R3CczSvr+ZVU+AVEg92tSVbfXI2
 UhihKn0hDkxCzCqBJ6UREc9R7QXIh0ma1OYXiMGPFz5l2D7EhoZhQG1S0WObKc6IPFn1GF5l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295557>

Hi Pranit,

I think this patch series is now in a fine shape. Just one minor nit:

On Tue, 24 May 2016, Pranit Bauva wrote:

> +		OPT_CMDMODE(0, "check-term-format", &cmdmode,
> +			 N_("check format of the term"), CHECK_TERM_FMT),

Just like with cmd_mode and CMD_MODE, it would be more consistent to use
CHECK_TERM_FORMAT (instead of abbreviating it) when the option is already
spelled --check-term-format and the function name is check_term_format.

It not only causes the eyes to stumble less, being consistent in naming
causes less typos and also makes it easier to dig into the source code
(think: `git grep -i check.name.format`).

Not a big thing, but if you re-roll for any other reason, it would be good
to make the naming consistent, too.

Ciao,
Johannes
