From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Mon, 02 Aug 2010 17:04:08 +0200
Message-ID: <4C56DE68.7010906@gnu.org>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>	<4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>	<AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com> <vpqwrs9nxi5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 17:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfwYr-0002w2-Kc
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 17:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0HBPEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 11:04:15 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35049 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0HBPEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 11:04:14 -0400
Received: by qyk11 with SMTP id 11so46048qyk.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FcPCNyFeFhRLmonYoeDnJDVIY0Ovw2ip9hif/7i2cEU=;
        b=fdYrWcCY2d1tnFN3VjFIkuBNFMAsZWvXcEMa7yGKxzRsXrzHpvdWC26VwXlFt43++3
         O6RtEiFnGiQ12zug5D1pB5ZkCuI0LPy4rc9T9GSUhMXfQLsS1W+uzsfAEJqMrkb7wybU
         /4vV54Pi6SDDpHy2JPg6ngG/LgSBT1dr/0wI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=t8rE2WpIuaACNnlIzryxSh72qsgKYrIuBHN5NkF88vCBw3FwBy1KnQiyM3UZNuJOn4
         Qu2QyJkoVGmpiyT9YAbs5f1ZCoR3rxSVp7IQPft9I2o0yvrW+ijbFuzLSi6CB8oy0jMP
         iljruuRY5UnY9LRauIzXOY9T8ohSvXhXGcA28=
Received: by 10.224.79.170 with SMTP id p42mr1789593qak.81.1280761453516;
        Mon, 02 Aug 2010 08:04:13 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id t24sm159572qcs.35.2010.08.02.08.04.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 08:04:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100621 Fedora/3.0.5-1.fc13 Lightning/1.0b2pre Thunderbird/3.0.5
In-Reply-To: <vpqwrs9nxi5.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152412>

On 08/02/2010 12:02 PM, Matthieu Moy wrote:
> I think this makes more sense for the user, and I've actually already
> been biten by the old behavior, running "rebase -i" from a doc/
> subdirectory, and wondering why my "exec make" was rebuilding the
> code itself.

I think it's a matter of habits, and I would surely be bitten more by 
the opposite problem: when I'm usually ready to rebase and test I'm 
likely to be in src/ (for packages that have one such directory) or tests/.

cd to the top-level repository is a logical choice since rebase is a 
repository-wide command (even though the particular set of commits might 
touch only a part of it).  It is easier to implement, does not have any 
problem with conflicts or otherwise with deletion, and easier to 
document as well.

If you decide to go with the other choice, however, I would _strongly_ 
suggest failing if the directory not exists.  After all most of the time 
the command ("make" for example) will be pretty unlikely to succeed.

Paolo
