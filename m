From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 16:52:46 +0200
Message-ID: <53971BBE.8030108@web.de>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jrnieder@gmail.com, gitster@pobox.com
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 16:53:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNQT-0002Rq-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 16:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbaFJOxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 10:53:21 -0400
Received: from mout.web.de ([212.227.17.12]:53800 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbaFJOxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 10:53:20 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MI5yY-1Wuv6x3d6M-003r1P; Tue, 10 Jun 2014 16:52:46
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
X-Provags-ID: V03:K0:Zvx5H+l8d+YDpbsC2zit9MIN21cBNuBb/EgeP6waa8giL6Tj4uM
 GquhCcW/7oIKkT8oS1Qk0aVAimeSsoOGjEXDxHF0/O6Y2Nq49o9KgKntr4ijayELeucLFHg
 lED1XkFaMK0Wxhc4c/DrvBvlprwIb5UNBAUnqjOo3e8J7342GOOYkKloy1b5UQoNX23Hiu5
 +2Fg2lTy43ujKi5K0WCkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251193>

On 2014-06-10 14.28, Elia Pinto wrote:
[]
>  		# before the first commit: compare with an empty tree
>  		head=$(git hash-object -w -t tree --stdin </dev/null)
> @@ -1056,13 +1056,17 @@ cmd_summary() {
>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
> -			test $status = D -o $status = T && echo "$sm_path" && continue
> +			case "$status" in
> +			([DT])
Does this look strange? ^
Should it be
case "$status" in
D|T)
