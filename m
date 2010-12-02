From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bash 4.0 breaks some completion scripts
Date: Thu, 2 Dec 2010 17:38:48 -0600
Message-ID: <20101202233848.GA8438@burratino>
References: <20101027235919.GB30490@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter van der Does <peter@avirtualhome.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	git@vger.kernel.org
To: 601632@bugs.debian.org
X-From: git-owner@vger.kernel.org Fri Dec 03 00:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POIk3-00031O-1K
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 00:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758178Ab0LBXjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 18:39:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43403 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216Ab0LBXjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 18:39:04 -0500
Received: by vws16 with SMTP id 16so1451967vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 15:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LYdrTKaEtM8SaZ65/4H8Zdmrq+k7CbJYuVnyyhMaCtY=;
        b=iS1Ozlsa0SuB40yDLIrts4P2TF1dyO1xZCkd483RyQ38b3MNn1nXOoHTy54ciy+1P9
         6idW7Gob0HQyHya51o4jus3hmrQ8lOe9d7oA2Vs9+UOT3JXgcmiH171Tqxn/daFIew2n
         NzVWdnC/VfhwyhzdUh53BEVxmmjanSHnPQYKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P7Dk6gqRJOjoJPJr8lOIfo4Kla/+gpgU6IbTHgK8nOCvOM5bkqyLNxcqcLmZGMKpWq
         BpvB605hIrPOmeHlgj55AcdaIOkUUcSY70esoAOyFpeH5j63ZJ/f60Z7G9PPRIbFV1F2
         VYsniO/YFpdYHdQ6JfD0brTQwpQPAVzZKjrNs=
Received: by 10.220.179.9 with SMTP id bo9mr169417vcb.188.1291333142910;
        Thu, 02 Dec 2010 15:39:02 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id e16sm205449vcm.32.2010.12.02.15.38.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 15:39:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101027235919.GB30490@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162752>

Jonathan Nieder wrote:

> Bash 4.0 changed the rules for completion word splitting so that
> they are incompatible with 3.x.  I think some Breaks: will be needed
> to ensure smooth upgrades.

Just FYI: Ah, at last some clarity!

>From the bash 3 manual:

 COMP_WORDS
	An array variable (see Arrays below) consisting of the
	individual words in the current command line.  The
	words are split on shell metacharacters as the shell
	parser would separate them.  This variable is
	available only in shell functions invoked by the
	programmable completion facilities (see Programmable
	Completion below).

>From the bash 4 manual:

 COMP_WORDS
	An array variable (see Arrays below) consisting of the
	individual words in the current command line.  The
	line is split into words as readline would split it,
	using COMP_WORDBREAKS as described above.  This
	variable is available only in shell functions invoked
	by the programmable completion facilities (see
	Programmable Completion below).

The workaround used by the bash-completion scripts is to paste words
from COMP_WORDS together (in _get_comp_words_by_ref).

If only the NEWS file had mentioned it. :)  
