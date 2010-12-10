From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Fri, 10 Dec 2010 13:03:32 -0600
Message-ID: <20101210190332.GA6210@burratino>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com>
 <20101209015926.GA31119@burratino>
 <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
 <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR8GB-00072y-3o
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab0LJTD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:03:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63209 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab0LJTD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:03:57 -0500
Received: by wwa36 with SMTP id 36so4060273wwa.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M4aCHN5PRHi9UI6Hi1VOpAcmuzHX5fFUitcaiNwyKns=;
        b=wfwYjKQ10r1+iPB1g2eGX7JePHG1Bevs1juIrDX2lCXbVrXvE3WMhYoJlJIr35C6I7
         xo1G/N5nW3ziOuXrQS/bLBd18Fe9vcQJkhKp63V+S77UyRVch77XHipbJCWN733Vjo06
         ZfT9yNp+9IMaCwrI0+qBiiNIvI+9oQhM+AsvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EnGxtT/PE9QuZM+PJn6qvMXgMBfzG2easENw37cc+aw4zoVpNCHLIaGQlx1XbxOZrO
         9Cjlf4oPdckr59g4Q55eHwCxiBESf+1IRqbWsTRgqxnLMR3BuXYltmxlAZsMQj6be9aa
         U8vqRwMTD/NjjAd/OlnzZH6lGuznJ0kmuaZVs=
Received: by 10.216.172.202 with SMTP id t52mr1281387wel.108.1292007836218;
        Fri, 10 Dec 2010 11:03:56 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id f35sm2320342wbf.2.2010.12.10.11.03.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:03:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163430>

Nguyen Thai Ngoc Duy wrote:

> Can we use ! modifier for other ^{} too? What I have in mind is how to
> say ^{commit} that has two parents. Or even better, "search from the
> given tip for a commit that has two parents and the commit message
> matches 'foo'". Hmm.. too complex. Perhaps "^{grep: <grep arguments>}"
> that pulls the whole git-grep functionality in.

My thoughts, in no particular order:

 - '!' can be a pain in the neck to supply on the bash command line.
   Single quotes and backslash quoting work while double quotes do
   not, unless 'set +H' has been run.  But that's not a huge deal and
   arguably it's a bash misfeature.

 - What is the intended use for this family of modifiers?  I sort
   of understand ^{:i/... } for people that forget what case they
   have used, but why the :nth and others?

 - Why do we have to carve out the namespace right away, anyway?  If
   we just ^{/... } for the ordinary "start here" search, that leaves
   room for anything after the { other than "/<pattern>" and a few
   fixed strings like "upstream", "tree", etc, right?  It might be
   easier to anticipate what syntax will be useful when there is
   functionality to go with it.
