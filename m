From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] fetch: run gc --auto after fetching
Date: Sat, 26 Jan 2013 17:51:10 -0800
Message-ID: <20130127015110.GB3224@elie.Belkin>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <20130126224038.GA20849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 27 02:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzHPH-0003SH-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 02:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab3A0BvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 20:51:17 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48432 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab3A0BvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 20:51:16 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so903354pad.34
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 17:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=so1ySOolkjQZ9+/jNHJCqam0RMBxKBjkAjTCxRvsyDY=;
        b=WkIxwQyQFsfVTFylNZPWFCFUjIOhGP9pCq0qDM2usjU+QMtEumubZrkSX2qQbn0vxc
         5794rGoLxqfq0DYuRS7I0qLgRZJu7cvJJYZ+jYjsaT5pMGWG9X0ThPPxRLlnqMaPkFu1
         B3jy100Ev/BAtEM9c0abCsCDn0Zi2cugVfHdsqnARDC3y/cMa+e8Wpe4706bglUSR3TW
         lu8moVFBftRWqbGM9vkLLrYT7cfEV5Ic/ZPTDwH7m9JfMB8FfAcQ0c0sz5jzS5MreiBl
         zCrIKsPTOdV4HqENXB7GulOgJdjNZh0OrPryUpSSHNh95l7t+OxKNtFwhhSCR3OV1E4Y
         UB3g==
X-Received: by 10.66.72.225 with SMTP id g1mr25021902pav.79.1359251476104;
        Sat, 26 Jan 2013 17:51:16 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ug6sm3478247pbc.4.2013.01.26.17.51.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 17:51:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130126224038.GA20849@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214648>

Jeff King wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -959,6 +959,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	struct string_list list = STRING_LIST_INIT_NODUP;
>  	struct remote *remote;
>  	int result = 0;
> +	static const char *argv_gc_auto[] = {
> +		"gc", "--auto", NULL,
> +	};
>  
>  	packet_trace_identity("fetch");
>  
> @@ -1026,5 +1029,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	list.strdup_strings = 1;
>  	string_list_clear(&list, 0);
>  
> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> +
>  	return result;

Good idea, and the execution is obviously correct.  Thanks.
