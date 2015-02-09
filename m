From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 05/11] ref_transaction_delete(): remove "have_old" parameter
Date: Mon, 9 Feb 2015 10:22:23 -0800
Message-ID: <CAGZ79kZNrFWvNJU_hmHmaMpYW4AZs3vEhKtzHEH+DMKgww7dTQ@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKsya-0005VU-P5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbbBISWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:22:24 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:45444 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933186AbbBISWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:22:24 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so18126370igj.4
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WTJKjstq1j1KpvtZacm0A9XnRz58zkJi9SujSg2JIcM=;
        b=F0ttpQE76y4FiXnfP1zUcr0rP7NcSdrda/KZ+i1u3V3YUj874x6IWuSpuQnxBgUNY0
         paEKd7d2jPfejdb9vdwREjI22xlReR5E6KWLwPNBFlL6vRVLHuX6EYvwpdV3woCDOQXz
         s8nYq+JFmZWrrp2JrNUWpkvqO4AYh+vMvBvj1a/Co3gi5IfjQeYdED46EhNSQf3GTV0i
         BsBFIfgc+n6rA0/DxWbQUerfJ6ctUo4Pp7tftz/3yI93nBwJe8EovROPXuJEFHJi77sp
         bAQdJcC2ilBM2mI1qh+FgEmZ0KyuylW4k9UVYRW5BVgn72N3S7vs7qi+/E7dYmzcItYr
         0fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WTJKjstq1j1KpvtZacm0A9XnRz58zkJi9SujSg2JIcM=;
        b=Q1bbTRfuPCF+FxtHRFd2gEjbK5L9j3tZl48I8G9tcChrry36YGx4uP3pj1l0trS4kM
         LiZddLkT/vhKg5rmB379QhwvXX/4FYTVN1Ieac19QYnBRAzJsWpborclQb50ghFBBm4r
         K214rP+6pBjsuPk/E8gX+b2B+QytVPxOD8H3Kkd9BAECtpVqpgPDs5hpgGJj1fF9k+lo
         9EB46HH1JWvslLUf3L6sQVenxSiaNiT1LhBcAkHDmdYbf6ZIyrEZsoH0uBGPkEZ0YVPI
         ORiVAlvVcxEasWs5WQMpq8BtKt2MTgrX8rSe49xiyiFqEoXTMNK7IzymwrOd8A0ODBCw
         Umug==
X-Gm-Message-State: ALoCoQl1SJDdBbLqWrDDA25LiWCx8cm/c7nRwmYkO/XQbCbGCmN0ZekblU4DNJlJ+Zrg3HMvyH94
X-Received: by 10.107.148.7 with SMTP id w7mr24691406iod.73.1423506143470;
 Mon, 09 Feb 2015 10:22:23 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:22:23 -0800 (PST)
In-Reply-To: <1423412045-15616-6-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263572>

On Sun, Feb 8, 2015 at 8:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Instead, if old_sha1 is non-NULL, verify it; otherwise, don't.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com> apart from the commit message.
