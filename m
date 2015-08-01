From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] Testing the new code
Date: Fri, 31 Jul 2015 18:02:52 -0700
Message-ID: <xmqqio8zakhv.fsf@gitster.dls.corp.google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 03:03:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLLCU-0004Gv-US
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 03:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbHABCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 21:02:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35831 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbHABCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 21:02:54 -0400
Received: by pabkd10 with SMTP id kd10so48831952pab.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bN8Zdl+gaLdk0xTi34NOa5jckqh95Ua74ZQtL9KKGEk=;
        b=AnWVt50T/arnj817q88NWDLDY3R3JtYX73aGnLdcn/1goGd046Z6VK0j7BpcTYSWj5
         mYue2vHI4P9cpKfs2/XMErk0y0jY4NhwTtsII9WXuX0CEA/qJZb6vYcuItf7Xna9Qkxq
         CLaodaFtiA6qro0FNsqafLgEs3c5G4KvXCqxQ6LNWcWz9zpowl1+GiNuZHOsw/2MeU4B
         Ds3uDmOfJGJ/Ko8mpCnd12o0yQhadlS43D9Ry2aCNPr0Mj7IP7Q5BtA8i55y69rl0Y6T
         RK9D5nRim4pDJl9PUx7G+4P7ifxwuNdSORUe/sB7to5bcDlOHekn1k0OVBRJj9USCkbh
         ofjw==
X-Received: by 10.68.241.103 with SMTP id wh7mr932603pbc.88.1438390974011;
        Fri, 31 Jul 2015 18:02:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id m2sm9781006pdp.4.2015.07.31.18.02.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 18:02:53 -0700 (PDT)
In-Reply-To: <1438384147-3275-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 31 Jul 2015 16:09:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275103>

Stefan Beller <sbeller@google.com> writes:

> -module_list()
> +module_list_shell()
>  {
>  	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
>  	(
> @@ -187,6 +187,29 @@ module_list()
>  	'
>  }
>  
> +module_list()
> +{
> +	# call both the old and new code
> +	module_list_shell $@ >/u/git_submodule_module_list_shell 2>/u/git_submodule_module_list_shell2
> +	git submodule--helper --module_list $@ >/u/git_submodule_module_list 2>/u/git_submodule_module_list2

You seem to be discarding the double-quote around $@ in both of
these two places.  Intended?
