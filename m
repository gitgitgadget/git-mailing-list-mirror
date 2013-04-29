From: Michael Heemskerk <mheemskerk@atlassian.com>
Subject: Re: Fwd: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Mon, 29 Apr 2013 15:39:50 +1000
Message-ID: <CAJDSCnOw6=iD1UiwjB3fmsapKq9Ai3bCcQ1qr_dCucEehw9mYA@mail.gmail.com>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
	<CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
	<7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
	<CACsJy8CT8r7ebE_q5ET+oicTY0NM4LAt1B61xwqfL8tLKc-4OA@mail.gmail.com>
	<CAJDSCnPt=wgT0UQirahvTyen9w_v4XTn0ABHJVCLeKLmC8BsHQ@mail.gmail.com>
	<CAJDSCnN_Va7r2BMLYSbsSzoUNs6YfYfihatb-u4jJw25w8qvZg@mail.gmail.com>
	<7v7gjmow6o.fsf@alter.siamese.dyndns.org>
	<7v7gjloqaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgov-0002rh-TU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970Ab3D2FkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 01:40:04 -0400
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44716 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750812Ab3D2FkD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:40:03 -0400
Received: from mail-vb0-f70.google.com ([209.85.212.70]) (using TLSv1) by na3sys009aob112.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUX4HqFaAzmEjqhUmcOCa0hz4cuqjbsdP@postini.com; Sun, 28 Apr 2013 22:40:03 PDT
Received: by mail-vb0-f70.google.com with SMTP id e13so3791999vbg.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-received:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=GoAR+mzQLyOzGWWi8/BOiIoCOKqubUvt4D+hC9B4IJ0=;
        b=HYQ+GtUR8Vusw6PNxZ8pBuaPUglhXtfTMsYSzyE+K+rMI464EZ3BiDCb/QLFuDw4RR
         LNWdDaAo/3c70Twzfv1/nERE+skGUdpfzQHkQxe+4ynv4mefshe7i8VkBTBeUmuG9y59
         CXQd1zqMGY4QfT3GuK0DF456ZtrftLG3wQup6bIiDmNDXpK6VAPzp+dUG6XKK29sup4u
         vNzbEl9gTF+dfRxxgObGMEk9TPCe9WuYgxTPVAktt5cwhnX92wasnGganB1gTnKoBblC
         mHzleZV2KH1FfMBTR/h7ZpzCR6JRLUzI0Cc9QKcdZzw8qQL/J7VG2PJqNbAyfT7t1fuI
         6BWQ==
X-Received: by 10.220.189.9 with SMTP id dc9mr19145950vcb.8.1367213990363;
        Sun, 28 Apr 2013 22:39:50 -0700 (PDT)
X-Received: by 10.220.189.9 with SMTP id dc9mr19145948vcb.8.1367213990256;
 Sun, 28 Apr 2013 22:39:50 -0700 (PDT)
Received: by 10.58.8.76 with HTTP; Sun, 28 Apr 2013 22:39:50 -0700 (PDT)
In-Reply-To: <7v7gjloqaz.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnqAOkeyjFQN/rMYCPOvdOI39+c1AwvE/vaqdpDXB1T6hfaOhkk8E0+cDS5SLtPzQn9jqoF8lgzHsc+5tYBPOBwgV1S2mwHV+/QPy9wAae8j6Q/2pMRvKPpCFTxipPvMSkYtELKHQREIw40ryS1uDJSy7DzwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222774>

Thanks Junio,

That looks fine to me. I'll try to find some time this week to create a
follow-up patch for removing pruned commits from the shallow file as
well.

Cheers,
Michael

On 29 April 2013 15:32, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> OK, the change the patch text shows looks sensible to me.  Can you
>> resend it in full, with the log message, your sign-off, and Duy's
>> "Reviewed-by:", so that it can be applied?
>
> I managed to reassemble what I _think_ is close to the original from
> a few messages by dequoting and fixing MUA whitespace breakages in
> them.
>
> Here is with a slight tweak to the log message.  Please holler if I
> grabbed a wrong version of the patch or made any silly mistakes.
>
> Thanks.
>
> -- >8 --
> From: Michael Heemskerk <mheemskerk@atlassian.com>
> Subject: [PATCH] upload-pack: ignore 'shallow' lines with unknown obj=
-ids
>
> When the client sends a 'shallow' line for an object that the server =
does
> not have, the server currently dies with the error: "did not find obj=
ect
> for shallow <obj-id>".  The client may have truncated the history at
> the commit by fetching shallowly from a different server, or the comm=
it
> may have been garbage collected by the server. In either case, this
> unknown commit is not relevant for calculating the pack that is to be
> sent and can be safely ignored, and it is not used when recomputing w=
here
> the updated history of the client is cauterised.
>
> The documentation in technical/pack-protocol.txt has been updated to
> remove the restriction that "Clients MUST NOT mention an obj-id which=
 it
> does not know exists on the server". This requirement is not realisti=
c
> because clients cannot know whether an object has been garbage collec=
ted
> by the server.
>
> Signed-off-by: Michael Heemskerk <mheemskerk@atlassian.com>
> Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/technical/pack-protocol.txt | 3 +--
>  upload-pack.c                             | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentatio=
n/technical/pack-protocol.txt
> index f1a51ed..b898e97 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -228,8 +228,7 @@ obtained through ref discovery.
>  The client MUST write all obj-ids which it only has shallow copies
>  of (meaning that it does not have the parents of a commit) as
>  'shallow' lines so that the server is aware of the limitations of
> -the client's history. Clients MUST NOT mention an obj-id which
> -it does not know exists on the server.
> +the client's history.
>
>  The client now sends the maximum commit history depth it wants for
>  this transaction, which is the number of commits it wants from the
> diff --git a/upload-pack.c b/upload-pack.c
> index bfa6279..127e59a 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -592,7 +592,7 @@ static void receive_needs(void)
>                                 die("invalid shallow line: %s", line)=
;
>                         object =3D parse_object(sha1);
>                         if (!object)
> -                               die("did not find object for %s", lin=
e);
> +                               continue;
>                         if (object->type !=3D OBJ_COMMIT)
>                                 die("invalid shallow object %s", sha1=
_to_hex(sha1));
>                         if (!(object->flags & CLIENT_SHALLOW)) {
> --
> 1.8.3-rc0-117-g5915a95
>
