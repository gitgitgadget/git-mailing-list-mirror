From: Stefan Beller <sbeller@google.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Mon, 2 May 2016 13:43:44 -0700
Message-ID: <CAGZ79kZVbK+bS_is-sbfMAhj0hPqpKUcFXAq0womwSXeWPKsnw@mail.gmail.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1462221687.4123.79.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 02 22:43:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKh4-0007QJ-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbcEBUnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:43:47 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34922 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbcEBUnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:43:45 -0400
Received: by mail-ig0-f175.google.com with SMTP id bi2so96766437igb.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2IxmZCUCYFA7nTaQ3dJns4WThJy9LC4ZcPjNoXaMXTM=;
        b=grH5hZ4k4lXiiYLGZUhd0QGWsNLjdvi+SubdhlEUaqkqlgGwXk7n+Q5e8kQpaf0NaT
         rsM34n8rdl3+TFXIiM0hj9nEZvuOD/BCm/kmUjp6XLIcSashtuqQRNEamdK589cq1MVw
         PyHDlqFwYu+45QNE/lj1N+XYFmDlPnMYF/vYtb/kvwUR75Ft57kK519ayZJCIlFMWCmc
         YoAVtsyquatPvHbSHJz8yHAy+6lbhFqoMbe7fHpzJzSNcZELVm0T82xHtZ51chh3osEs
         IjyTT8Yi37PezaN6ZVH9HAiX6WA4ZvHOODeC20NUrpq8+DcszljBiDGE/VXO5LjtId3I
         uOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2IxmZCUCYFA7nTaQ3dJns4WThJy9LC4ZcPjNoXaMXTM=;
        b=DnVgDL8Ku+13vfuKelGcU7AvpaUYFva8JQiIjSSgJBKD3joEXM3Q807o8qbBin8uAD
         CfkiGRKHGcqWz5WJ9D939Tzh+A+hVKWuQvTnVxT/MenZtI/cAcE2H4k222heCFXyWYVe
         CgfzcvrEz0Da7nOCqMXocPANGWUKRSY56dy+BsJUpSzzDMZTqJJet+FEsdyOg9NPKip2
         DpSTutvg5nQiWIK8pyzuL2n84Mq7OBZjCoAiVMy9MbGphTY1GKcWqQkLNgQe91O+WC+I
         BCaFOw4Z34VWXPQRIcPrvC9zv98mmeVhoiCfDmTeaTJzmwkryqRGncTHadKH21jGYIGM
         OjNQ==
X-Gm-Message-State: AOPr4FVzzLwm4PRS02XW5JFQztU+OFPcDqY19LQmYg1GrrglUsg7Snc6wKj7Ai6HvCdOGXD0KV+OWd8/QP+tVz99
X-Received: by 10.50.29.45 with SMTP id g13mr22748786igh.93.1462221824859;
 Mon, 02 May 2016 13:43:44 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 13:43:44 -0700 (PDT)
In-Reply-To: <1462221687.4123.79.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293287>

On Mon, May 2, 2016 at 1:41 PM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>> Hi David,
>>
>> here are my patches for a protocol v2.
>>
>> ("Negotiate capabilities before doing anything else", or as code:
>>
>>         static void upload_pack_version_2(void)
>>         {
>>                 send_capabilities_version_2();
>>                 receive_capabilities_version_2();
>>
>>                 /* The rest of the protocol stays the same,
>> capabilities advertising
>>                    is disabled though. */
>>                 advertise_capabilities = 0;
>>                 upload_pack();
>>         }
>> )
>
> Overall, except for the comments I made, these patches seem sensible.
>
> Would it be possible to add some docs on the new protocol when you re
> -roll?  (I know these are just the initial patches, but it really helps
> me to see an explanation along with the code).
>

Thanks for the review :) I'll fix the issues and add some docs, though
the reroll
may take some time. I really want to get the submodule groups stuff
done as well.
