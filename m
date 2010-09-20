From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 36/37] merge-recursive: Make room for directories in D/F conflicts
Date: Mon, 20 Sep 2010 10:06:00 -0600
Message-ID: <AANLkTin0ra6JL+jbyOwfssvSxh9FB-BCnvFcR45_=ZkS@mail.gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
	<1284971350-30590-37-git-send-email-newren@gmail.com>
	<4C97483D.8030605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 20 18:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxisc-0003JU-4O
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 18:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab0ITQGD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 12:06:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38633 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab0ITQGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 12:06:01 -0400
Received: by fxm3 with SMTP id 3so747903fxm.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1+Zht1LgTaB+YElhLQIphLznYZyBWE/lzT7v/Ifrz60=;
        b=YI5bXMwuN2pgPBwYSH2YT7xA/YQJfyEq/a4ZBGtP0vr/rKCYa9c7CuTtE0MTdWbor1
         0io+4D75DHniSdwcHs4NxzekevBrmdGRAMkKQP6ezwGBN6dFNtyUYq/RJfdTqx4R9OG1
         B7qD9Gr1Hpmu+lwV67DdtDEXcJC8wOOmWXIMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ceva+1DuYJNeXbGo6xC2rgEicTaLNnPPPcccGIdC23r43Mv/FiqFg9GpnNLD4OncJz
         IMAXnX3q/DsUXcr4qhyZdYoyqwPMd6zegObGgWHCCkJoh5aA5slJCMFL0gSdbofEBrnr
         e2UpCnnfuwf/c7Lx/TxMz7zV8ezzPlUAOhB5Q=
Received: by 10.223.121.134 with SMTP id h6mr4783549far.74.1284998760266; Mon,
 20 Sep 2010 09:06:00 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Mon, 20 Sep 2010 09:06:00 -0700 (PDT)
In-Reply-To: <4C97483D.8030605@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156635>

On Mon, Sep 20, 2010 at 5:40 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 9/20/2010 10:29, schrieb Elijah Newren:
>> + =C2=A0 =C2=A0 =C2=A0* NOTE: This function relies on the fact that =
entries for a
>> + =C2=A0 =C2=A0 =C2=A0* D/F conflict will appear adjacent in the ind=
ex, with the
>> + =C2=A0 =C2=A0 =C2=A0* entries for the file appearing before entrie=
s for paths
>> + =C2=A0 =C2=A0 =C2=A0* below the corresponding directory.
>
> I don't think that this is a generally valid assumption. There can be
> other entries in between:
>
> =C2=A0 this
> =C2=A0 this.txt
> =C2=A0 this/file
>
> (where your focus is on "this").

Ah, this was one of my two big remaining questions about this series
(the other being whether all the o->call_depth > 0 cases have been
fixed).  Thanks for the clarification.

Would a sort of the entries string_list using df_name_compare() give
me what I need?

Elijah
