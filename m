From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v4] Add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Thu,  4 Feb 2016 11:12:37 +0200
Message-ID: <1454577160-24484-1-git-send-email-alonid@gmail.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:14:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRG04-0000kq-OU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965666AbcBDJOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 04:14:46 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38182 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965359AbcBDJO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:14:29 -0500
Received: by mail-wm0-f47.google.com with SMTP id p63so107378589wmp.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zIdmHx64QhMOTY+MZmsnh45PzAqkonADOVikzpBlE+4=;
        b=IigmKkN7Rv3AyXsjky/R4hsmNjEt2jWijDVdhmtEDc7uc/94rFYgVwyh1VZvw9Ag9l
         Fa2X65TDjhlVOVWmDyazVZs3lh5UVJ3hVKYswlhXXRVhnX+6b/Zi6L1L7itHQuLAzpVg
         XNnYqrsYt5WtJ2vQj0FyWayGvqOWuw/PQ1sIv+2vv76B6QnEMp/Xjs3ac6w7AZ2WL+zT
         DXVnmTRTKHTmfX+l+Pmfmt+itvCiDBpZ8Y3TbGc/uPWhmuA/TcB29vQqZJkUTFd618dU
         7+9dwzupSIK5dePiqvc1PXfJAL1SLWDksxhYKgxPRF3MUqjTuQ46J2CPh4cuB9C02DK9
         H7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIdmHx64QhMOTY+MZmsnh45PzAqkonADOVikzpBlE+4=;
        b=N6PYLniRUeQ+viHBcH7NLTIpv6AfERHtSSuzHIugOLPwkmQla3bW7fp/KWAC8VkYpT
         FMrGcUZJFQ/FnSZRNTvKEri2/qBzituJVh5uxNmrkfb0OYoptyjTmkL/hDugWuw39XaM
         oiWprIbwWWJcqI8zoo+K+xf5NHZjZMpcqgiqhYrRt/ktgkXkcj7wNrsO42EVemR5uwJz
         /whKWyTI3lcZYuRNNmOI+nz90LLUqbaw5lYXvENCkfV82V/6MXYwnqegQ7Wk4H3+Dtgd
         yZRbmwjkmkZn/5J7sMSoAYG0P5gktYLtzCw/i8G3m4UiMCvmlzwuxDkdNay3Z+womLcb
         BjEw==
X-Gm-Message-State: AG10YOR97WOlKCAuNT3L/zyH1VRlPbMcXITlRPqqI8ogbW/6v2NYiPg5YYMbkzueECMnmA==
X-Received: by 10.28.64.131 with SMTP id n125mr27340911wma.65.1454577267939;
        Thu, 04 Feb 2016 01:14:27 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id c7sm10806435wmd.13.2016.02.04.01.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:14:27 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285441>


v3->v4 changes:

 * Added cleanup patch for ident.c
 * Added Jeff's refactoring to fmt_indent
 * Renamed configuration option to useConfigOnly.
 * Extended tests to include a clone, EMAIL env.

Also, ran the entire Git test suite to make sure nothing's broken.
