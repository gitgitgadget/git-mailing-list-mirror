From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [WIP/PATCH v3] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Sat, 21 Jun 2008 00:04:57 +0200
Message-ID: <485C2989.6060406@gmail.com>
References: <1213487844-685-1-git-send-email-LeWiemann@gmail.com> <200806201408.05254.jnareb@gmail.com> <485BB578.3040605@gmail.com> <200806202003.55919.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 00:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ok4-0006sG-IQ
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 00:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbYFTWFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 18:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755211AbYFTWFE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 18:05:04 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:47955 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000AbYFTWFC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 18:05:02 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1421483fkq.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=Wab5IIpyAlTrqHZozq7ZhjVMGXz8tk7Gjbp/3GYdOEo=;
        b=Motp9Pq9jGjh2mI5fEng1gr3ZY8gGWG/UbnawJD+lnOoF4rtJEfQtSY6iZtOCWAsIq
         gSaUtb9cijmKI4Zz6MKBWoxxZyGHti/3WxIauGGP2Yx9ghsLweYGGXaNxXI/0N9dJwSl
         sWTJQMrZBGUdcg8VumfGNlvL4EkCfVbeOQtvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=HCY+nsi7OkHh9INMIMt5htlvjI2m9CwwsD5XkShft3uf9W1ZaZ/GoSJQQ8JENHzfQs
         KuZxV2BkLjEr9IVZdTBX08ovrn57xxTpFstmcsoRQRr3uWSU+EptCamWLBi7IIBirL2J
         yox7oqkWH35yJgIDa11EYPJFFWSrI0z38aLDQ=
Received: by 10.78.195.10 with SMTP id s10mr1795167huf.32.1213999500466;
        Fri, 20 Jun 2008 15:05:00 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.240.210])
        by mx.google.com with ESMTPS id 20sm1664318huf.3.2008.06.20.15.04.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 15:04:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806202003.55919.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85678>

Jakub Narebski wrote:
> Lea Wiemann wrote:
>> Sure; FWIW I'm generally in favor of having a large initial commit for 
>> new independent files [...]
> 
> I just think that having this separate could help bisectability in
> the case of errors.

Hm...  I wouldn't think that bisect could be necessary for a long linear 
(sequential) test script, where the errors are clearly locatable.

> What could be added is different types of stage output: filenames with
> '*', '+', '=', ':', '?', whitespace, etc.  Checking if submodules
> doesn't trip gitweb would be good idea too.

Yup, filenames with ampersands and semicolons would be fun, too. 
(Submodules seem to work, but that should be covered as well of course.)

> [Full SHA1s] would reduce number of operations when crawling gitweb output.

Right; changed.

> Actually ->cgi_application(<path>) is implemented using ->cgi(<sub>)
> in TWM::CGI.  The bug is that it uses straight "system($application)",
> 
> [it] would fail if you run test from the directory which contains spaces,

OK, now I see what you mean.  Well, awesome, borked lirbareis.  I've put 
this as a TODO into the commit message; will take care of it later.

>>>> +our $baseurl = "http://localhost";
>>>> +our($params, $url, $pagedesc, $status);
>>> I think we can use 'my' here;

Fixed, and thanks for the offline explanations.

-- Lea
