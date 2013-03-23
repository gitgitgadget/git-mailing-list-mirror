From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Fri, 22 Mar 2013 17:06:28 -0700
Message-ID: <20130323000628.GM12223@google.com>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
 <20130322182211.GD12223@google.com>
 <20130322183306.GA32448@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Sharpe <josh.m.sharpe@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 01:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJBzn-0001Xd-Rq
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 01:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741Ab3CWAHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 20:07:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59593 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab3CWAGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 20:06:33 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp6so162570pab.36
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZSNg2E9P1ZtpU6EN0vA7ZepcY23GJVkYgzlgBNldH0A=;
        b=Rpp8LFLPw7cB+AlQe3+fXYWtpgjSJ6GAe4sFZfrHHbkZcrUK7dmTfMqxsj3VaIGCfd
         fXDcm+nVIbp4nz6Z0XBJHFw9l23KMopZy4IjB2jeKS4J+x6uK4h7wvQ7KfsiE+H3bxQ2
         YTOT8RM/+gmTTOwMVI/M4f8Zk9Xj/xmIytbd755NtTH+k1c20cmm4PGUCgJXa1Wq7IBN
         jErCfDZYe+g8fkDnj/qjpjQEHYB0Vxv7pHQ3f1Bg5E6xvvrLTjisZI+M5nZiEivinVzo
         v/uj89PsDUYXCMm4ar0kqO/vycsaJWxNVGG/uDCeFXOOMJ5CqIgOiFzG9/qs/wHd/tpG
         kojQ==
X-Received: by 10.66.163.69 with SMTP id yg5mr6017044pab.109.1363997193162;
        Fri, 22 Mar 2013 17:06:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id xl10sm4724034pac.15.2013.03.22.17.06.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 17:06:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130322183306.GA32448@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218870>

Jeff King wrote:
> On Fri, Mar 22, 2013 at 11:22:11AM -0700, Jonathan Nieder wrote:

>>                                     It would be easier to understand
>>    the configuration if ~/.gitconfig could spell out the rule
>>    explicitly:
[...]
>>    It sounds hard to do right, especially considering use cases like
>>    "User runs into trouble, asks a privileged sysadmin to try running
>>    a command in her untrusted repository", but it is worth thinking
>>    about how to do.
>
> I'd rather not invent a new language. It will either not be featureful
> enough, or will end up bloated. Or both. How about something like:
>
>   [include]
>        exec = "
>          case \"$GIT_DIR\" in)
>            */dev/*) cat ~/.config/git/dev-config ;;
>                  *) cat ~/.config/git/nondev-config ;;
>           esac
>        "

Yes, an existing language like shell or lua would presumably be the
way to go.  The scary aspect of shell is the "Prankster sets up a
malicious configuration, asks a sysadmin to help in her repository"
scenario.  Of course we already have that problem with command
aliases, but if the sysadmin has perfect spelling then aliases would
never trip, so...

Hopefully that's enough information for anyone interested to start and
understand the relevant variables at play.

Thanks,
Jonathan
