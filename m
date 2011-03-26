From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/3] gitweb: Split gitweb.js, improve JavaScript
Date: Sat, 26 Mar 2011 12:08:42 +0100
Message-ID: <201103261208.44548.jnareb@gmail.com>
References: <1301089586-8534-1-git-send-email-jnareb@gmail.com> <4D8D112A.5020703@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Mar 26 12:09:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3RMZ-0000xT-Uj
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 12:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab1CZLIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 07:08:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38643 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab1CZLIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 07:08:52 -0400
Received: by bwz15 with SMTP id 15so1433194bwz.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dwsmoITsYUry6dkgAEtWpx8yFwUnAw+I4fsRc8Q1X/s=;
        b=n0Q6oTPOgprdSRtfwn83Ci7/QmjsegPhY3jnw/cuqnBlTo2MiOfb6uTZBE+i3p7FeL
         KgH0DrepfO36hb8Soio/RJjPdmxh8qDebbfOXVzGakEFGic5H84sBV7Ogdg7znyTnzoa
         hLTiiNW8IGx/00vuZCJEkjPXdmuqSwqrYASPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v7izeLJ/foxceZQNrG3UvbNzLarLijWNcQioSX7llRZoKhs9pcNEpzDGxKgMFAZPCe
         ZPVF32Ql1XQY4ZfJE75gThXn7W4qbcTIQqwP8HRClCCPk2kYnR2r9aq9G2VPHmjptE9Q
         KZJSv0pDvW06zqBivtS9y4hgkQ+12DFeGTZ4k=
Received: by 10.204.82.166 with SMTP id b38mr1652188bkl.207.1301137730872;
        Sat, 26 Mar 2011 04:08:50 -0700 (PDT)
Received: from [192.168.1.13] (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id z18sm1335895bkf.8.2011.03.26.04.08.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2011 04:08:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4D8D112A.5020703@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170050>

On Fri, 25 Mar 2011, J.H. wrote:

> The only thing I would comment on is that we may want to document (for
> the build process) a way to force a certain ordering of various files.
> Case in point we probably want to force the things like various global
> defs (what I'm proposing in the timezone stuff) at the top and let the
> function defs go below that.
 
Actually I don't think that matters, at least not if JavaScript files
contain only variables and functions, and do not include any code that
is actually run when file is loaded.  A very simple test (below) 
confirms that.

In JavaScript variable declarations ('var' keyword) and function 
definitions ('function' keyword) get "hoisted" at beginning.  

> Other than that this all looks good.

Thanks.
 
-- 8< --
<html>
<head>
<title>JavaScript test</title>
<script>
// -------------------------------------------
// B

var varB = 'varB';

function fooB() {
  fooA();
  alert('varB='+varB + '; varA='+varA);
  return 'fooB';
}


// -------------------------------------------
// A

var varA = 'varA';

function fooA() {
  alert('varA='+varA);
  return 'fooA';
}


// ===========================================
// main
fooB();
</script>
</head>
<body>
test
</body>
</html>
-- >8 --
-- 
Jakub Narebski
Poland
