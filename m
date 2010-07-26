From: Andreas Ericsson <ae@op5.se>
Subject: Re: object/pack size x5 larger than a fresh clone?
Date: Mon, 26 Jul 2010 10:09:30 +0200
Message-ID: <4C4D42BA.6070900@op5.se>
References: <AANLkTimL+wfu+yMPutq2VHD6vO2AtaF_7FpWt8aZPm1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 10:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdIsY-0000yj-3F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 10:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab0GZIRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 04:17:36 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50956 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753678Ab0GZIRf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 04:17:35 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 04:17:35 EDT
Received: from source ([209.85.214.47]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTE1EnsuDrp4PW7RLV7xevHGdB/iLPulr@postini.com; Mon, 26 Jul 2010 01:17:35 PDT
Received: by mail-bw0-f47.google.com with SMTP id 10so3428524bwz.20
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 01:17:34 -0700 (PDT)
Received: by 10.204.179.19 with SMTP id bo19mr4964310bkb.209.1280131772009;
        Mon, 26 Jul 2010 01:09:32 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id a11sm2661801bkc.0.2010.07.26.01.09.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 01:09:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <AANLkTimL+wfu+yMPutq2VHD6vO2AtaF_7FpWt8aZPm1c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151816>

On 07/24/2010 11:57 PM, Hin-Tak Leung wrote:
> Is there any reason why a fresh git clone has a object pack around
> 140MB but one that has been updated over the years has it over 700MB?
> (even with git gc --aggressive --prune=now and git fsck?)
> 
> $ du .git/objects/
> 711364	.git/objects/pack
> 
> $ du *wine/.git/objects/pack
> 144692	git-wine/.git/objects/pack
> 144604	wine/.git/objects/pack
> 
> I had a problem with git fetch  "Cannot obtain needed object" from
> wine's git repository (which seems to be something to do with http
> proxy, although AFAIK I don't have one) since about 2 weeks ago which
> obviously does not apply to anybody else as I would have heard from
> wine-devel.
> 
> Editing .git/config to switch from a http url to git url cure it...
> but in the course of investigating, I git clone fresh (there are only
> about 3 local changes so I could just git-format-patch them and move
> them)
> 
> http://source.winehq.org/git/wine.git
> git://source.winehq.org/git/wine.git
> 
> and I am a bit surprised that the new clones are so much smaller than
> the one I have been working on these last few years. (I have had the
> old one for at least 3-4 years).

To make a fair comparison, try
  git repack -a -f -d && git prune --expire=now

in your old repository. Be warned that this will remove all commits
reachable from reflogs but not from branch heads or tags though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
