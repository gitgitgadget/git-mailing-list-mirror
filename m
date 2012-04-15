From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sun, 15 Apr 2012 13:58:41 +0200
Message-ID: <4F8AB7F1.1020705@gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki> <4F8A0F96.5060408@gmail.com> <20120415011118.GA4123@ecki> <4F8A8211.2010908@gmail.com> <20120415105943.GD6263@ecki> <4F8AAE7C.1020507@gmail.com> <20120415114518.GB9338@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJO6X-0003gI-5o
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab2DOL6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:58:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54772 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2DOL6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:58:46 -0400
Received: by wibhq7 with SMTP id hq7so4330348wib.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=z0oyfUXNODVAwLrVCn+t6/C5JbOVffnvCvlhwg2Uybg=;
        b=h8wjM4fvThOoGpYWdDHCCNrSWxSYu9uVWCxzQeFn/UoRfJn6V8fo3JjuYKmFUgga+G
         vavuTmMIyD6wP54uPMsBIRfrA1HpTMdi26k69EcrfTrk1Bo23M1D7jI39gPZhiERK5rB
         AsdGqrC8tHTGEx3SN7+/xgobX1jPgOyD3OMobLEeOM8PONy1lvu6jIMv1mgdEovGxTz8
         P8B+Okv/lQ0hxzQ1eIRUVKlWCCNWlhCaBSO7fw6x/tyVqBdS27EyQ7nf8qwk5AbQ7uXZ
         VPxv2g0DdPVy3FgpXsOQmOhYg87n1VNlGjhlExS1wEuoshaVLoSwUpK1GiYYZBFfvUWd
         mhcg==
Received: by 10.180.91.168 with SMTP id cf8mr2804185wib.0.1334491125359;
        Sun, 15 Apr 2012 04:58:45 -0700 (PDT)
Received: from [87.8.92.183] (host183-92-dynamic.8-87-r.retail.telecomitalia.it. [87.8.92.183])
        by mx.google.com with ESMTPS id ea6sm11572925wib.5.2012.04.15.04.58.43
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 04:58:44 -0700 (PDT)
In-Reply-To: <20120415114518.GB9338@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195563>

On 04/15/2012 01:45 PM, Clemens Buchacher wrote:
> Hi Stefano,
> 
> Almost there. :-)
> 
> On Sun, Apr 15, 2012 at 01:18:20PM +0200, Stefano Lattarini wrote:
>>
>> $ git 'fast-export' '--use-done-feature' \
>>       '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
>>       '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
>>       '^refs/testgit/origin/master' 'refs/heads/master' \
>>    | git 'fast-import' \
>>          '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
>>          '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'
> 
> To simulate a git push, you have to run fast-export from localclone and
> fast-import from the server directory. I.e. starting out in
> t/trash directory.t5800-remote-helpers:
> 
> $ (cd localclone; git fast-export --use-done-feature \
>       --export-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
>       --import-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
>       ^refs/testgit/origin/master refs/heads/master) |
>   (cd server; git fast-import \
>          --export-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
>          --import-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks')
>
OK, I cut & pasted your command; it ran successfully, with this output:

git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:       5000
Total objects:            3 (         0 duplicates                  )
      blobs  :            1 (         0 duplicates          0 deltas of          1 attempts)
      trees  :            1 (         0 duplicates          0 deltas of          1 attempts)
      commits:            1 (         0 duplicates          0 deltas of          0 attempts)
      tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
Total branches:           1 (         1 loads     )
      marks:           1024 (         6 unique    )
      atoms:              1
Memory total:          2294 KiB
       pools:          2098 KiB
     objects:           195 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize =   33554432
pack_report: core.packedGitLimit      =  268435456
pack_report: pack_used_ctr            =          2
pack_report: pack_mmap_calls          =          1
pack_report: pack_open_windows        =          1 /          1
pack_report: pack_mapped              =        253 /        253
---------------------------------------------------------------------

Thanks,
  Stefano
