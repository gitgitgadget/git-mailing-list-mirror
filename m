From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 15:17:08 +0200
Message-ID: <CAC9WiBg2+ep2EMhcofh14TqG+eujbDg51UDLGm3OK=ntOFuRxw@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	<CABURp0r+rzRqHv9vMX3Nsxn_p2R7zf8AsY=_Cg98xWRWn+7bkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:17:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upeji-0002We-RV
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575Ab3FTNRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:17:10 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:45566 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab3FTNRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:17:09 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so7929304oag.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nnVqjMDiG9N8B0w00KlbtDecTlBiMoj+t8eA1qJnhc8=;
        b=nXo+gmsa3RbRJUqsHhAEBLXPQzFwASplIKsu/B1pyu3E78UW7cPpCwZ06iwkF99m+L
         GTqivRKDiqG1bcY1lNYWi2CmCRm5f94l22oKSuZxqSacIEK/fhYiXBERnFRQv1OEys0K
         y5WOiGj7n+OR/xroVvWucHJfod30sDcfhnYPpF+3I49/bD8+sfjN/PkH+KK1Xg4vCPMK
         AaN6wk2GLFPY4jbyppK8hbw+BQe4MM1Z5XajG/VM0aHALyA3PFEstD8J3B2tq1omu8Lq
         k3D+qIBK64ZgD/ZHHhEJ3c3+KyLzCZ8jxd61iQmwoqq1y1P3LllRa/JtiYFoDRgt8Y+D
         5+sQ==
X-Received: by 10.60.144.163 with SMTP id sn3mr4277059oeb.112.1371734228948;
 Thu, 20 Jun 2013 06:17:08 -0700 (PDT)
Received: by 10.182.200.169 with HTTP; Thu, 20 Jun 2013 06:17:08 -0700 (PDT)
In-Reply-To: <CABURp0r+rzRqHv9vMX3Nsxn_p2R7zf8AsY=_Cg98xWRWn+7bkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228497>

Hi,

On Thu, Jun 20, 2013 at 3:04 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Thu, Jun 20, 2013 at 6:14 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>> I'd like to write a script that would parse commits in one of my repo.
>> Ideally this script should accept any revision ranges that
>> git-rev-list would accept.
>>
>> This script should consider commits in master differently than the
>> ones in others branches.
>>
>> To get the commit set which can't be reached by master (ie commits
>> which are specific to branches other than master) I would do:
>>
>>   # "$@" is the range spec passed to the script
>>   git rev-list "$@" ^master | check_other_commit
>>
>> But I don't know if it's possible to use a different git-rev-list
>> command to get the rest of the commits, ie the ones that are reachable
>> by the specified range and master.
>>
>> One way to do that is to record the first commit set got by the first
>> rev-list command and check that the ones returned by "git rev-list $@"
>> are not in the record.
>>
>> But I'm wondering if someone can see another solution more elegant ?
>
> I do not know if I would call this elegant, but I think this
> codification of your "One way to do that" is at least small and mostly
> readable:
>
>    git rev-list "$@" |grep -v -f <(git rev-list "$@" ^master)
>

Yes, thanks.

But I wanted to be sure that git-rev-list can't display the
intersection of several sets before going forward.

--
Francis
