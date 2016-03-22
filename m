From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command
 line
Date: Tue, 22 Mar 2016 11:56:28 -0700
Message-ID: <20160322185628.GA19993@google.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:57:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiRUG-0007ci-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbcCVS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:57:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36428 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcCVS47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:56:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id q129so38146814pfb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZjguVihdrKWZSks5+URI3Sx0cyJlwp8HRlOaNwXBMk=;
        b=ZWfZ+kjUx32FJJkSL4PzFUhSbdQySqMaNYjT7z5j7QD10vJyfZ5D7LWt0fEpL/tvi/
         88BITXxwM2PuGY7fKUkqddrYIRP8g1xapdZFG5sPyzX81vo+P79K2zRBK8lFHGaLanjQ
         297xu40HVLrrOrYtic/TAY8JyZ954O48NPY0mnkf911BGFyflAu7uiW5yOgfQ8qpT8GU
         d/tPEh6zTfc2aUA4EyiXqXv82C4CpaygB91PEL4zsOJBALmuMqSRRpP3s3p+IBl5xewJ
         yth3+8lbI43sEv1MTzP7Vlw9vSoowJQd2r1a3YxA07b/Fmn4iLX7vkCvCVnvwMuVOjTj
         QrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZjguVihdrKWZSks5+URI3Sx0cyJlwp8HRlOaNwXBMk=;
        b=d7bxYjqZKy68j5dyvlJGE4pjxsq/TukpNJTiDwELGmMM8lKbMXgNdgq1V5O7D/zytK
         ht5OnwlbbNueJh1lhljoJxWKHNavxo7fBtDsiOknCZei+SCKX6SW96UxxWU53ZKHejxX
         PAt/94gMvJ3imbhcW7Oyyg3YLDNTGV2wcYZKVyhj8VCTkCNojzywFEwNIhkw5PhBKeDe
         9jRoMniYAKu9LutQkFZTm9IPzrri/lmv2i+GUSla28Sietejw3inKBcEOejpz0FBlSMB
         WqrHJmQTQfuSpBW9yAvgQwrYo4payf8joSHak2qTfTwuHc6KcyyckJukSizYGF4OYW+x
         75+Q==
X-Gm-Message-State: AD7BkJIEFj82xxP7JQaZhKOM+3ooozbo+3fqUIAKnULciFpoUtCw6EiIhJ0PDFnWm+FdaA==
X-Received: by 10.98.31.21 with SMTP id f21mr55122401pff.134.1458673018512;
        Tue, 22 Mar 2016 11:56:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:694a:ddce:573a:2ea8])
        by smtp.gmail.com with ESMTPSA id g28sm50061920pfd.25.2016.03.22.11.56.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 11:56:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289543>

Hi,

Jacob Keller wrote:

> Due to the way that the git-submodule code works, it clears all local
> git environment variables before entering submodules. This is normally
> a good thing since we want to clear settings such as GIT_WORKTREE and
> other variables which would affect the operation of submodule commands.
> However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
> preserve these settings. However, we do not want to preserve all
> configuration as many things should be left specific to the parent
> project.
>
> Add a git submodule--helper function, sanitize-config, which shall be
> used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
> except a small subset that are known to be safe and necessary.
>
> Replace all the calls to clear_local_git_env with a wrapped function
> that filters GIT_CONFIG_PARAMETERS using the new helper and then
> restores it to the filtered subset after clearing the rest of the
> environment.

This is failing for me when I use "git submodule add" with a remote
helper I whitelisted with GIT_ALLOW_PROTOCOL, with current "next":

 $ bin-wrappers/git submodule add persistent-https://kernel.googlesource.com/pub/scm/git/git sm
 Cloning into 'sm'...
 error: bogus format in GIT_CONFIG_PARAMETERS
 fatal: unable to parse command-line config
 fatal: clone of 'persistent-https://kernel.googlesource.com/pub/scm/git/git' into submodule path 'sm' failed

sq_dequote_to_argv doesn't like the space at the beginning of
$GIT_CONFIG_PARAMETERS.  Reverting 14111fc4 fixes it.  Known
problem?

Thanks,
Jonathan
