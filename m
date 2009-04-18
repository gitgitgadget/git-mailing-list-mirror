From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH] rev-list: embed "struct rev_info revs" into "struct
 rev_list_info"
Date: Sat, 18 Apr 2009 12:56:04 +0200
Message-ID: <49E9B1C4.50100@gnu.org>
References: <20090418064328.ad64accf.chriscool@tuxfamily.org> <20090418191125.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 12:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv8F3-0003JH-Bm
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 12:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbZDRK4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 06:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbZDRK4G
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 06:56:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:55470 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbZDRK4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 06:56:05 -0400
Received: by fg-out-1718.google.com with SMTP id 16so215626fgg.17
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=FMnePeeCIcv7Z+TWraki9cRwEk4sXEpblEThwqRRsBA=;
        b=aobIztFjAmJJcaJh3BH1SePFBQ7GtXrgJK4SOUab4LLUCfKN3Q2AxIw3NGoSFjcrNZ
         kUKx3AVhZynNaOaDWZOKcP43UN6cq2WbxUqWH00JMeAw5CaUL0DcD2Cr2rRf60ekFz07
         tPFGcB3AXtxub+bXCbii2kTsyQIlNV7RifHfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=c4GZTgFtJXNO/R2GIfZayjlaHNqdiOFRxzEktxpVDR21SHMMpq+/3LAL8g8lJ8ztml
         D1lAZvk8SuDHS2odlq6xKRee2eM+NtOfBXS6P3q7p2XdK8Pej4ir7MukQeBcrIUcfZNs
         yb6Vm0LITRgIxbm6Sj7WiJvpgqVfeG0VFSbaA=
Received: by 10.86.65.18 with SMTP id n18mr2654222fga.25.1240052163250;
        Sat, 18 Apr 2009 03:56:03 -0700 (PDT)
Received: from scientist-2.lan (93-34-163-159.ip50.fastwebnet.it [93.34.163.159])
        by mx.google.com with ESMTPS id d6sm30434fga.3.2009.04.18.03.56.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 03:56:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <20090418191125.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116823>

Nanako Shiraishi wrote:
> Quoting Christian Couder <chriscool@tuxfamily.org>:
> 
>> There are downsides to this patch. First it is big. And "revs" is
>> initialized once when doing "memset(&info, 0, sizeof(info))" and
>> once in "init_revisions".
> 
> I'm sorry if it is obvious, but is there any upsides?

As the patch shows, the lifetime of the revs is the same as that of info
(i.e., there are never memcpys from something into revs).

Paolo
