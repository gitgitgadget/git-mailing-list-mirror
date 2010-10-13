From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Tue, 12 Oct 2010 20:05:19 -0700
Message-ID: <91EEA44C-E519-4375-BD9E-68D5C3D7C4EE@sb.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com> <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org> <20101013024034.GA26483@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 05:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5rex-0005vT-MN
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 05:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab0JMDFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 23:05:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38487 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab0JMDFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 23:05:23 -0400
Received: by pzk34 with SMTP id 34so1404042pzk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 20:05:22 -0700 (PDT)
Received: by 10.143.8.3 with SMTP id l3mr7114172wfi.125.1286939122430;
        Tue, 12 Oct 2010 20:05:22 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x35sm2951667wfd.1.2010.10.12.20.05.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 20:05:21 -0700 (PDT)
In-Reply-To: <20101013024034.GA26483@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158908>

On Oct 12, 2010, at 7:40 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
>> On Oct 12, 2010, at 7:24 PM, Nguyen Thai Ngoc Duy wrote:
> 
>>> Special case "**/" (also "path/to/**/") is probably good enough. You
>>> might need to handle all combinations of "**/" and other optimizations
>>> in excluded_from_list() though. Can you make a patch (or a few
>>> patches) for it?
> [...]
>>                                                                 At
>> this point I'm actually in favor of simply assuming all paths that
>> don't start with / can be matched at any level
> 
> As a long-term change with early warnings and proper deprecation
> procedure that may (or may not) be an ok idea, but in the short
> term it is certainly a no-go.
> 
> If linux-2.6 is any indication of what to expect, some projects are
> not using / in front of any paths with / at all.

Another possibility is using this new behavior for core.excludesfile and possibly .git/info/exclude, but not for patterns in .gitignore files. The benefit here is any existing project that uses .gitignore files will be unchanged, but global (and possibly repo-wide) patterns can benefit from the new behavior. The drawback is this would introduce a behavioral difference for patterns depending on which file they're in, which is probably not acceptable.

I will look into how much work is required to support **/ patterns without doing a wholesale replacement of fnmatch(). Hopefully it won't be infeasible.

-Kevin Ballard