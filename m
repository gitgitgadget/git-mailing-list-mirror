From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 1/5] gitweb: prepare git_get_projects_list for use outside 'forks'.
Date: Mon, 30 Jan 2012 14:42:03 +0100
Message-ID: <201201301442.06707.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120130095252.GA6183@server.brlink.eu> <20120130114447.GA9267@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 14:41:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrrUQ-0004IS-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 14:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab2A3Nll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 08:41:41 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab2A3Nlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 08:41:40 -0500
Received: by eaal13 with SMTP id l13so1117782eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 05:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TI3WoEzexx0phdNfB62J9F5WW9z6ePfL+T6TLxw/Imo=;
        b=uVj+tEFm0dR6jBW52cjFT6V5bgBoPULmvujSAzVXobLKsJ9ZpExy0tOQ73f6pDi2ds
         912BABUFD3M/O1x0R2a95bHqNix3CG+2Yn4Kn2Sci5JWAxD4xJ+qQF25z/hF0kxImFsR
         gBrYfQAykLTQeaYS0V2DOf76EoAbeBhwZrP7o=
Received: by 10.213.8.199 with SMTP id i7mr2847862ebi.129.1327930899783;
        Mon, 30 Jan 2012 05:41:39 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id b3sm21695081een.2.2012.01.30.05.41.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 05:41:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120130114447.GA9267@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189359>

Bernhard R. Link wrote:

> @@ -6066,7 +6069,7 @@ sub git_summary {
>  
>  	if ($check_forks) {
>  		# find forks of a project
> -		@forklist = git_get_projects_list($project);
> +		@forklist = git_get_projects_list($project =~ s/\.git$//r);
>  		# filter out forks of forks
>  		@forklist = filter_forks_from_projects_list(\@forklist)
>  			if (@forklist);
> -- 

The '/r' non-destructive modifier for regexp replacement is quite new 
invention and requires Perl 5.14, while gitweb requires Perl 5.8.x
something.  Please don't use it.

You can use this instead.

  (my $filter = $project) =~ s/\.git$//

-- 
Jakub Narebski
Poland
