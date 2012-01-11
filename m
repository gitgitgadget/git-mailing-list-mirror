From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] use generic pci_iomap on all architectures
Date: Tue, 10 Jan 2012 17:51:07 -0800
Message-ID: <CA+55aFwXj2ELrTDSgFfSC2Usz99-24uFSznAP34feJiCttwayQ@mail.gmail.com>
References: <20120105145836.GA2751@redhat.com> <20120106083141.9c14a8d2d09539c6a6c0db75@canb.auug.org.au>
 <20120106083916.9588034bde22a6803e327aa9@canb.auug.org.au> <20120106084701.8f704542754db826deda318a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf303f6aeabca73b04b636dee7
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 02:51:43 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RknLo-0004TN-U3
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 02:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933648Ab2AKBvb (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Jan 2012 20:51:31 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64394 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab2AKBv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2012 20:51:29 -0500
Received: by ghbg21 with SMTP id g21so106478ghb.19
        for <multiple recipients>; Tue, 10 Jan 2012 17:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=zVArlu8j7NN+CufxLanIwLK4zivTG/bxXcUbwoLBOe4=;
        b=bRT1wMkauklG/bP8znnrDHqGwYMaX7fizaXvztMJevPDwkjgyYgX/hGfKhLUAmPYMx
         xZq3t+saGWT7mmdOEsGcEsHmbovENsjnmSZBBC/Y3FtzpYPNWXL7W8LU11DBo/mTwyQp
         t/Hyq8/iSGGJKYcOaqJXVnMxoGmN48/BfXsOk=
Received: by 10.236.195.37 with SMTP id o25mr29672696yhn.46.1326246688237;
 Tue, 10 Jan 2012 17:51:28 -0800 (PST)
Received: by 10.236.175.170 with HTTP; Tue, 10 Jan 2012 17:51:07 -0800 (PST)
In-Reply-To: <20120106084701.8f704542754db826deda318a@canb.auug.org.au>
X-Google-Sender-Auth: PUH29zsNcnS44j8E7w2LlETIPGs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188309>

--20cf303f6aeabca73b04b636dee7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 5, 2012 at 1:47 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> On Fri, 6 Jan 2012 08:39:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
>>
>> So why does you pull request refer to "commit
>> 805a6af8dba5dfdd35ec35dc52ec0122400b2610", I wonder? =A0Is that just wha=
t
>> "git request-pull" produced?
>
> I see, "git request-pull" just puts in whatever you specify on the
> command line rather than the merge-base ...

.. and that is a fairly silly misfeature, since it makes the "since
commit xyz" largely meaningless.

I suspect we really should make "git request-pull" show the merge
base(s) as the "since commit", because that way the output of git
request-pull is "stable", and doesn't depend on what particular random
state you've synced up to since.

Junio, I think the patch would be as simple as the attached - totally
untested - one-liner? Comments?

                            Linus

--20cf303f6aeabca73b04b636dee7
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gx9oxpud1

IGdpdC1yZXF1ZXN0LXB1bGwuc2ggfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9naXQtcmVxdWVzdC1wdWxsLnNo
IGIvZ2l0LXJlcXVlc3QtcHVsbC5zaAppbmRleCBkN2JhMTE3OGFlNzUuLjY0OTYwZDY1YTFjMiAx
MDA3NTUKLS0tIGEvZ2l0LXJlcXVlc3QtcHVsbC5zaAorKysgYi9naXQtcmVxdWVzdC1wdWxsLnNo
CkBAIC05Niw3ICs5Niw3IEBAIGdpdCBzaG93IC1zIC0tZm9ybWF0PSdUaGUgZm9sbG93aW5nIGNo
YW5nZXMgc2luY2UgY29tbWl0ICVIOgogICAlcyAoJWNpKQogCiBhcmUgYXZhaWxhYmxlIGluIHRo
ZSBnaXQgcmVwb3NpdG9yeSBhdDoKLScgJGJhc2VyZXYgJiYKKycgJG1lcmdlX2Jhc2UgJiYKIGVj
aG8gIiAgJHVybCR7cmVmKyAkcmVmfSIgJiYKIGdpdCBzaG93IC1zIC0tZm9ybWF0PScKIGZvciB5
b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAlSDoK
--20cf303f6aeabca73b04b636dee7--
