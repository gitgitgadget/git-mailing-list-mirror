From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Thu, 5 May 2016 13:37:05 -0700
Message-ID: <20160505203705.GB22726@google.com>
References: <1462477952-6669-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQ1T-0007wT-L3
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbcEEUhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 16:37:10 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35028 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbcEEUhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:37:09 -0400
Received: by mail-pa0-f51.google.com with SMTP id iv1so39435331pac.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mqo9+q/vhvCzKxmPFmfubijBvH9lmNWpGwUfR5YSRS8=;
        b=XQSliW31WhcfMH0L3i1qvRTeMG5TPsbruBQmOz/Zh4hn/K+E5OgmZvOalcJkH9DT8s
         msa4uZsFrS6R1leyHjLaZvB3kmNegm59aqrzy9/3z4GgTRQ3Af5RvxYvu+8dyq3miRan
         OPWEDSNjoVqTRVcLIGmpfwj8w54hb2fv4ccsM5gA/nSkmRofQTBSAP6qp2+EcL7I3lQN
         T5dBGvqSdDTYz8VFWew2viGuugJBuHYQajMGynGuRo9Jcs5nOTGeBnF+2oeib95z4Whj
         RPM0U5nj+iNKFxLdmPcpQzK+jRRJX5rY5Sh3T8lkiRt72q/zXP0SVFMCQpO48vj7dxaA
         N/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mqo9+q/vhvCzKxmPFmfubijBvH9lmNWpGwUfR5YSRS8=;
        b=Sm9wqaUYZhzlUb5SRs0GhFUK04CkcSPTvYjW9njQDQ4ZtLZ4JBJwMOkVmsw0rBSt23
         p1y66Y3s8cJvUhVRE0nOS48jPZcXKsh59KojdHIWdFb78dGDjaPQFI/W086MnvXQHt3W
         Zm6YQssqJLGKihBc8EmU8IWkpMY4wNeAPKdJTy5bNx4OS5Grc9Z0Pd3xz452B/9k9fBp
         HdOh3hhPM7JUkfyk9sj9UbZJZMHG2BntLebp7tmjOR/cKaR9L/JWRCAtftwOpiSkKe7l
         4pkdqFPaMCuqpYvjDnVrzudSIJmWsSd0UpZGLgYEKLqocKKrXHE7T8rZkle14/pJEY5r
         qN9Q==
X-Gm-Message-State: AOPr4FXCYuLSDzM6WBp2kDlExUC9mi6WlDHBYbh71hWfloW8BlxtuW1hr0oy+nTZTD/yqA==
X-Received: by 10.66.90.196 with SMTP id by4mr23653832pab.117.1462480628411;
        Thu, 05 May 2016 13:37:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b4e5:604e:91a7:f7e7])
        by smtp.gmail.com with ESMTPSA id x89sm15657951pfa.87.2016.05.05.13.37.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 13:37:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462477952-6669-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293677>

Stefan Beller wrote:

>>        $ rungit v2.6.6 submodule deinit .
>>        error: pathspec '.' did not match any file(s) known to git.
>>        Did you forget to 'git add'?
[...]
> So instead of a pathspec add the '--all' option to deinit all submodules
> and add a test to check for the corner case of an empty repository.
[...]
> Signed-off-by: Stefan Beller <sbeller@google.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
