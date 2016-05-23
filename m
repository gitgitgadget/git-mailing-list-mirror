From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] worktree: simplify prefixing paths
Date: Mon, 23 May 2016 16:26:33 +0700
Message-ID: <CACsJy8B6L97-07xgzduGRY5wbTCotLphzgmHDuzd6ZH81YFE3g@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160522093356.22389-1-pclouds@gmail.com>
 <20160522093356.22389-7-pclouds@gmail.com> <CAPig+cSpoi0eMKQPqKG6+skc87dgDLZiLJZJLUk-iyd13P3E3g@mail.gmail.com>
 <CAPig+cTYZORwm-Wc3JkzHaaasOxJytYiFVgayb21fWrvXnf_Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 23 11:27:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4m8j-00030X-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 11:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbcEWJ1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 05:27:05 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36216 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbcEWJ1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 05:27:04 -0400
Received: by mail-it0-f54.google.com with SMTP id e62so27003288ita.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kx4FPV6vhZfpeUmVACBLHAhnt21N39ZXDpaOpBashWo=;
        b=VpOqAbkO8XYeM38CJUFQ+79FkkkOJQS8tecDr+d1cLtszumrgEwdG3D9LdcnuYG9p4
         p4ra7g7p71FBNQ3g52k+54gIqZB+x31ttZMvEMHTpMlToYEU/GrBQXQ1+p8o4Sl6jB/Y
         OSdwwSFslLPBK0E/sa5LIxML1DxshnFKLrZ68C6d2y2AyF3YfTAQ51lgeNdXo4K8wpxT
         vcC2z4QmxhmyhXEYglmLtFWdiN2nyghiEK40aHboCkmWtamHX3W/HBFdddcZGNDmCOU/
         K5Rt130HEXGf9pcgqWIN47pe+NvrhA6NhFRHK8D0njKnA+G1vCMLTJV27qfoMvSURF9g
         0eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kx4FPV6vhZfpeUmVACBLHAhnt21N39ZXDpaOpBashWo=;
        b=QZ6XM3XMniiV7K8G+NZHZLJYzN9llOA2+QEP3B9vG4X44JzdVCqUhb8nDR7/UwuTzz
         Thl2FFdGnNUIHIriIp69CbQvbKlRSjLieOYfw6Z+2ZbP8HpSSe125XJLtczAWU1FFQR2
         GaeAHuTmvDeycIzNT8m7T+JEC5PDaD43Y4e6CMlvv8754mRCHQF8DpHS/6rYApDgX41w
         wRtORsmms3GKlx02TRKTXj/sDwTvf6m+HVw7eX2MQ54mi5ZjSLZyNwKYmboK+hphzi+4
         G0c+5/Sh6POecQrex88RU0YGO+/uAr7PSBMV4Vc0187yJ/zFpPXIPTNwqE9oEGwPyyTA
         QKQw==
X-Gm-Message-State: AOPr4FVNj/IJ2Fr9Zjp5EhM6CBTVdsqKVskH/qMAZxREUG3nNp+KHleN9EexzfhGS6avuhHFQXtxY6XL523MFA==
X-Received: by 10.36.43.23 with SMTP id h23mr9187634ita.57.1463995622808; Mon,
 23 May 2016 02:27:02 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 23 May 2016 02:26:33 -0700 (PDT)
In-Reply-To: <CAPig+cTYZORwm-Wc3JkzHaaasOxJytYiFVgayb21fWrvXnf_Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295314>

On Mon, May 23, 2016 at 11:31 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Sun, May 22, 2016 at 7:32 PM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Sun, May 22, 2016 at 5:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> @@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const=
 char *prefix)
>>>         if (ac < 2)
>>>                 usage_with_options(worktree_usage, options);
>>> +       if (!prefix)
>>> +               prefix =3D "";
>>
>> Considering that all the other existing git-worktree subcommands
>> already handle NULL prefix acceptably, it makes me a bit uncomfortab=
le
>> that this "fix", which could be local to add(), leaks into all the
>> other subcommands, thus making the assumption that they (or other ne=
w
>> subcommands) will never care about the distinction between NULL and
>> "".
>>
>> Not a big objection; just a minor niggle, probably not worth a re-ro=
ll.
>
> Okay, I see that you're taking advantage of the prefix=3D"" in patch
> 5/6, as well, so it's not benefitting only add().

Yep. 'add' so far is the only command taking paths. The next four,
lock, unlock, move and delete, all deal with paths and need to deal
with NULL prefix otherwise.
--=20
Duy
