From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 08:35:58 -0800
Message-ID: <20130102163527.GA31196@elie.Belkin>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com>
 <20130102153933.GA30813@elie.Belkin>
 <20130102161848.GA18447@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRIq-0004Ac-JD
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab3ABQgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:36:09 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43713 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab3ABQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:36:08 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so8112842pad.10
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 08:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7v5w/WQXzlIIdkyFjvacqLjpPahX5oXK9u2ZKg0ri0E=;
        b=nkz7n4ff5EseiE9KpYoFgZUEPazedPcRr2gbOW/BJ69O0UhnSTnxDjzLV7+kVbL9aY
         1t8noHSiz/ZsonIua96boJefREIB0B6pt5FQEMLm10VHxJrWGpSgHmWqU9oW2nauH2rh
         Up3uIzyrLT1mVAF7/Q6g1ggzjzF53Iy3zqB/hPXCTUkrthyuexwhzVGUz5TVuWpes8K0
         kRjXTZKOcMrlsB0lvCAoqCWzQDqs0y8nXcO/LbNVJctO/zS1zW+k3He5oTiusc+tfhUU
         BkLGU/U9Ji9kSuwAwh0ELdCqsd+YljN/1+7qPkoh8XriuPMdTbI4hFhhNc3dRgtNdMuL
         nF4Q==
X-Received: by 10.68.83.68 with SMTP id o4mr147049641pby.25.1357144567537;
        Wed, 02 Jan 2013 08:36:07 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id w5sm29565838pax.28.2013.01.02.08.36.05
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 08:36:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130102161848.GA18447@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212521>

Eric S. Raymond wrote:
> Jonathan Nieder <jrnieder@gmail.com>:

>> The former is already loudly advertised in the package description and
>> manpage, at least lets you get work done, and works fine for simple
>> repositories with linear history.
>
> Two of the three claims in this paragraph are false.

Give me a break.

Are you telling me that when multiple users read a manpage that states

| WARNING: for certain situations the import leads to incorrect
| results. Please see the section ISSUES for further reference.
[...]
| Problems related to timestamps:
[...]
| Problems related to branches:
[...]
| Problems related to tags:
[...]
| consider using these alternative tools which proved to be more
| stable in practice:

and a package description that states

| The git cvsimport tool can incrementally import from a repository
| that is being actively developed and only requires remote access
| over CVS protocol. Unfortunately, in many situations the import
| leads to incorrect results. For reliable, one-shot imports, cvs2git
| from the cvs2svn package or parsecvs may be a better fit.

and decide to use the tool anyway, this is not evidence that the tool
is invaluable to them, despite its shortcomings?

Perhaps the users reporting bugs didn't read the manpage and package
description (despite quoting the same passages and explaining why they
used the command nonetheless) or I should ignore the judgement calls
they make.

Consider the following workflow:

 1. Update imported project periodically using git-cvsimport
 2. Hack, do code archaeology using "git log -S" and "git bisect",
    etc.
 3. Fall back to a web browser and cvsweb to confirm conclusions.

You are telling me that it is not a regression to change the workflow
to the following:

 1. Try to use git-cvsimport.
 2. Wonder where that command went.

Meanwhile Junio has already suggested a way out.  Just rename the
command.

Hope that helps,
Jonathan
