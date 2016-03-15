From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 16/17] editor: implement git_sequence_editor()
 and launch_sequence_editor()
Date: Tue, 15 Mar 2016 08:00:00 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603150755450.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-17-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afixs-0005i3-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 08:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbcCOHAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 03:00:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:56194 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbcCOHAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 03:00:17 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LlV4F-1a4T0110dT-00bHUp; Tue, 15 Mar 2016 08:00:02
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457779597-6918-17-git-send-email-pyokagan@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:alfyW+pTCqwm6x9e9paCJTjzwnWtrx9vGTzVh1dFP0Pp/9W3LEk
 6oYg9ys0V5KxpUNlHZuV4lhAgOwKBJ9vOXf6s+ylsM5BJ/Le758XymvZWuvSEgF5lGpQJL/
 ZtBunlQp5BKZjwUlx0NyS+esvGFkq3qzjHYcaplC7dyi0l6QNP5ZZgI0CiFHRNl50RBhkRg
 Z6/pS9TVBvjgi9XT8FcvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H6eVgkKtBvY=:eYUdu3NSw4JJdwsUTtBxOc
 ACngHW15ozmt/TuXlcWTMK/3xKdg4g1YD7kXyR7nqt1Ab0Rb6FgYbJDY3Fpfbh3GIOKdvLZc8
 7XdJrQF/LpTosvNXLQ8OQ9yXnx/n1ETH7tDH77/0dfxYnK7nHOHwFFMWsk2rLvcz7JfroEcLy
 ExOkdvgRBP7RPDhK8+Sd1RBtuvWKumVTWhQsfe85dQLX73osPFfB/JhLmWI8MT33rX0TZJ17o
 8FU/TK3KgSmTEEJod90asf0XGV2uBlIyBvS3VZgdT8HQkU9/hv9eCHt3fI5IYmRbU9JJbHFKa
 2vuYwStMvk+hsGJ4twle8O3yWqBQVeGxu+hoFa5bsycbVMeuGkF5LL7F/5TUakC/nz1BSC2C9
 O9eeU8hJmldGRuDPEpTJ8ExkpnnH6tQR0iySkCJQMaP3wzwPXobuQNEgC85v+mXSOcezSpE22
 XOIoov+8ayad3a51P8epX2HyKEofM3f5ms9En1wvN4C8EOO6upvf54aUCXkZhiXU214r9I620
 GSA8Km08nVqZyIZatSJcmLmybThNsQiDqnUmxydnqVIli7CrDedrB8PZ+jVLRojCQSryGxQXi
 fN18Ar0mS7H5LaRIpFxtO6hQCl2gMj3dXMx+0FSxmz0oxk6fPgPvwy3SIYSv/YcMBRv2uxbv2
 m7K1EvXxL8aGXy8i9/4vJjSlB3ucvlvSeM2uPDJWobkxAZaeRRIjc2lOy6QVcezDETR4R112T
 +bKxmCeNNaEqpA40T8v48nQEJAQUsqkJn2m6o7KQ2WKuA1dmZWji484N/t4jJ8cSMGAZxcap 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288836>

Hi Paul,

On Sat, 12 Mar 2016, Paul Tan wrote:

> Signed-off-by: Paul Tan <pyokagan@gmail.com>

This commit message is very short.

> ---
>  cache.h  |  1 +

No need to clutter cache.h with a function that is only to be used by the
sequencer. IOW let's make this static in sequencer.c.

I would also prefer pairing this short function with the change that
actually uses it (in my topic branches, I like to compile with -Werror,
which would result in a failure due to an unused function), in the same
patch.

Ciao,
Dscho
