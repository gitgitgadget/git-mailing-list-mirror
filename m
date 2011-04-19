From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problem when using --cc-cmd
Date: Tue, 19 Apr 2011 16:52:56 -0500
Message-ID: <20110419215239.GA22632@elie>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Joe Perches <joe@perches.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCIrB-0007z1-Ud
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1DSVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 17:53:09 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47826 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab1DSVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 17:53:06 -0400
Received: by yia27 with SMTP id 27so47394yia.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GioBhQO0qgP7m7ZiM9WKS8PlUfEwj4kDH5XlBGqQLE4=;
        b=LTrCpwuglmHLnePy7WqZdhpQ1LB8tPAkstjbu1cfVsqoqa+vjdiZfWOJ6wjQ0CoXAq
         ilIqUk8nc9d78S9QrID8LH2ZfU25N7wfmC5gOl+p2i1S92NNPbXmB8kpHeHkpcPR6jla
         ED5rQswWOJ8/G+OIhd3u9bAW6wM6x/f9HlRAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NDkaknO6NdlBrlp000SDtsg4tUvFuplVZ/Pz7wQsPyPGPJ4wr5FA1gxolA8TQAcpke
         7Fs+CUxZhnV26L1elGtcsvzbSQ3RuCF8PPeT0+9Mvn8xfbWHcDSQ4F2ktUBjAlFc4Bin
         DihZRbeH7vlz5g7z6nvVeNL49bXIJDnikDMU8=
Received: by 10.147.100.20 with SMTP id c20mr3753683yam.5.1303249984125;
        Tue, 19 Apr 2011 14:53:04 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id d36sm295909and.4.2011.04.19.14.53.01
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 14:53:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171820>

Hi,

Thiago Farina wrote:

> when I run:
>
> $ git send-email --to linux-kernel@vger.kernel.org --cc-cmd
> scripts/get_maintainer.pl foo
>
> I'm getting some lines like:
> Use of uninitialized value $cc in string eq at
> /home/tfarina/libexec/git-core/git-send-email line 964.

Yes, sounds like a bug.  Cc-ing some send-email people for tips.

On the other hand, using --cc-cmd=scripts/get_maintainer.pl does not
sound like a great idea to me.  On one hand the output of
get_maintainer.pl is not an unadorned address per line like --cc-cmd
expects.  On the other hand, at least some versions of
get_maintainer.pl returned more addresses than are likely to be
interested people (by using --git by default).

I think get_maintainer.pl is meant to be a starting point for tracking
down who might be interested in a patch and should be followed by
careful investigation.  (That means making sure that there is a
reasonable number of people and the reasons given by --roles ouput
make sense, and maybe even glancing at some messages by them from the
relevant mailing list to make sure the script has not gone haywire.)

Hope that helps,
Jonathan
