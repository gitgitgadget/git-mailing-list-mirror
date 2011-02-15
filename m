From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] smart-http: Don't use Expect: 100-Continue
Date: Tue, 15 Feb 2011 15:54:28 -0800
Message-ID: <AANLkTikVp0xC3OciJ7eN=P4+5_Pu=KPeO5X_+b_Nv30N@mail.gmail.com>
References: <1297789044-17978-1-git-send-email-spearce@spearce.org> <7vr5b9nkzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUjO-0000Yu-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625Ab1BOXyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:54:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60707 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1BOXyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:54:49 -0500
Received: by iyj8 with SMTP id 8so632542iyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:54:49 -0800 (PST)
Received: by 10.42.174.3 with SMTP id t3mr7458775icz.474.1297814088839; Tue,
 15 Feb 2011 15:54:48 -0800 (PST)
Received: by 10.42.219.134 with HTTP; Tue, 15 Feb 2011 15:54:28 -0800 (PST)
In-Reply-To: <7vr5b9nkzb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166905>

On Tue, Feb 15, 2011 at 11:42, Junio C Hamano <gitster@pobox.com> wrote=
:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> diff --git a/remote-curl.c b/remote-curl.c
>> index 04d4813..3d82dc2 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -356,14 +356,59 @@ static size_t rpc_in(const void *ptr, size_t e=
ltsize,
>> ...
>> +static int probe_rpc(struct rpc_state *rpc)
>> +{
>> +...
>> + =A0 =A0 curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite=
_buffer);
>> + =A0 =A0 curl_easy_setopt(slot->curl, CURLOPT_FILE, buf);
>> +
>> + =A0 =A0 err =3D run_slot(slot);
>> +
>> + =A0 =A0 curl_slist_free_all(headers);
>> + =A0 =A0 strbuf_release(&buf);
>> + =A0 =A0 return err;
>> +}
>
> Hmm, I am getting
>
> =A0 =A0remote-curl.c:403: error: call to '_curl_easy_setopt_err_cb_da=
ta' declared
> =A0 =A0with attribute warning: curl_easy_setopt expects a private dat=
a pointer as
> =A0 =A0argument for this option
>
> Shouldn't the above be giving a pointer to buf anyway?

Yes.  Please squash your patch into mine.  I'm surprised my build
doesn't have sufficient warning flags enabled when I built this. :-(

--=20
Shawn.
