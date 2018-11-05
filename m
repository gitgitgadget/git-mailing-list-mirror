Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FAA71F453
	for <e@80x24.org>; Mon,  5 Nov 2018 22:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeKFHni (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 02:43:38 -0500
Received: from esa7.kohls.iphmx.com ([68.232.141.60]:47095 "EHLO
        esa7.kohls.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 02:43:38 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 02:43:37 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=kohls.com; i=@kohls.com; q=dns/txt;
  s=KohlsProdCloudOut; t=1541456504; x=1572992504;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=kDhuzyRDHiNuhVAhSAaAlZnBk3TIB10WgOxEVgJj/qw=;
  b=XH4BPsBDF5MzdJRATZ4qcuj8hM4UZVRY6iLo18jzCuE2AWS1dyXRYMZl
   mVEHI4P3rYunYGpXAGhIsjAp+PvckvIX+DXt67ojOZ0GOmGZGpCMK0ybQ
   38EAGP8gzvv2ufKytCnHNYWTnNfcfm079OPHdsAVtGpPhPit8STpbmMvl
   Un3CRxNJESBModYHHgxK0XLtLURG/CUoJidWMcOjmSNVCxcj5hm7j01JI
   uJN/4Coi0KN47/fLbGnt/xLhpbjjxZqBuNCfOp3wRg3W9v/Cpyzb+KVS2
   U3SG4keI43vdq0y+8Za9Kmb8XFIvzoTHbdEBqc/NDNyaozXueoq3PsE2A
   A==;
X-Passed-Outbound: yes
X-IronPort-AV: E=Sophos;i="5.54,469,1534827600"; 
   d="scan'208";a="168444724"
Received: from mail-qk1-f198.google.com ([209.85.222.198])
  by esa7.kohls.iphmx.com with ESMTP/TLS/AES128-GCM-SHA256; 05 Nov 2018 16:12:08 -0600
Received: by mail-qk1-f198.google.com with SMTP id k203so24677707qke.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohls.com; s=kohls-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxxeRn3R742Z/yXsrOx0p3hvtQoQIdbOxmZMnlebdIo=;
        b=Rc6OthLL0isHFtrq0dWeYW2FtXZ45wM1pEqnC91ySiEYU6h1ziTKGZrtdGfQ77tUP5
         wAllwZNf/uvkypoYAy1xPnmYCLv1L0WNC6Vs7h4Zwltb2hSBLRQZYjlHFqQdR+QR2P0j
         wy52UgMk+HS4FLyFQ3sXOwFQwg3YqDTlHQ5S1PDi/OIRbUYwYs4dhGuRhdtI1kGybWlc
         CL4bovWpqV+HQXoaA438d0sqmpFYefb/+0j5ILpqk8wfuvTGPqpvCZzLk1TyeaNKIPxx
         KX8318rMjtm4t3E5SWrgWTmYycU8EvHoOQ6t76KjvGN2PepDEd9Efvxbfb/E58yrvFA3
         Aj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxxeRn3R742Z/yXsrOx0p3hvtQoQIdbOxmZMnlebdIo=;
        b=kaJcOgb0j1te0QrXhtvoJBLt5XqknZSJQTKdgWH9JYh9Vwt39U7Z+Ydl1mg1Kcl8MD
         9+i1ApCj5uRmhoTm29uhzFMveU0x+uGlY+migAdK+Jvs2zT/WQ/rc+whu0d6yorGf6mU
         rVzS7aNdBirtRedwQuz2ghHIhR4M1QgHu4U1vK4oLCSfMzDMWRGGtfhW4PE+RX+hC6AJ
         awQFM9kuqfcJc/EitXGOMFmX1NetGLpEi9V9AkfojouJYhXBtD0UdzYrcKuuX6z2TyL1
         lpERScmm9bNKUO4j8gL4IuEP1Ld5WqKbgS9OVWAJLwe83PApGpkABxvi85tjlLzPE8YS
         AH/w==
X-Gm-Message-State: AGRZ1gLzxC6uSdNwatYp5GoXWpkmdgtXI7ujo7o/2HB42K841fzAMD+r
        3ldiP4huyR+GZ1jQS7k7TsC31Vib5dVg3IvHBx8Uo+ihjHag4E4NgC4A61RJs8+ZFZCtvriT9NQ
        zkPi0mI4lE2xpMiDhILwUcg74P5vHtmCxUSFZgps=
X-Received: by 2002:ac8:66c9:: with SMTP id m9-v6mr23371517qtp.349.1541455927867;
        Mon, 05 Nov 2018 14:12:07 -0800 (PST)
X-Google-Smtp-Source: AJdET5c9jR9sgXgR2p4esqe24yXAKNTU7fGIkghb4sYqr7EAgF86xPc2XgYU/a0Jx8+zYkzrtmRt7r4ufFNI36p+yec=
X-Received: by 2002:ac8:66c9:: with SMTP id m9-v6mr23371498qtp.349.1541455927547;
 Mon, 05 Nov 2018 14:12:07 -0800 (PST)
MIME-Version: 1.0
References: <CAEL6bLrY5OgsjrZSSHDfYgrjefninR4wuZhGCsop_f-HCH7Jmg@mail.gmail.com>
 <20181103164423.GE731755@genre.crustytoothpaste.net> <4b32622b-e600-44b4-e1f7-0713d4839a86@talktalk.net>
In-Reply-To: <4b32622b-e600-44b4-e1f7-0713d4839a86@talktalk.net>
From:   Peter Kostyukov <peter.kostyukov@kohls.com>
Date:   Mon, 5 Nov 2018 16:11:56 -0600
Message-ID: <CAEL6bLq9nsjNmcs-q02ACSB=qwTNTuDe1WtkO92MGr0nONojyQ@mail.gmail.com>
Subject: Re: Git Slowness on Windows w/o Internet
To:     Philip Oakley <philipoakley@talktalk.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R29vZCBwb2ludC4gSSdsbCBjaGVjayBpdCBvdXQuIFRoYW5rcyBmb3IgdGhlIHRpcC4KClRoYW5r
cywKUGV0ZXIKVGhhbmtzLAoKUGV0ZXIgS29zdHl1a292ClNlbmlvciBTeXN0ZW1zIEVuZ2luZWVy
CktvaGwncyBEZXBhcnRtZW50IFN0b3JlcyAtIEtJQwpPZmZpY2U6IDI2Mi03MDMtNjUzMwoKCk9u
IFNhdCwgTm92IDMsIDIwMTggYXQgNjo0OCBQTSBQaGlsaXAgT2FrbGV5IDxwaGlsaXBvYWtsZXlA
dGFsa3RhbGsubmV0PiB3cm90ZToKPgo+Cj4gT24gMDMvMTEvMjAxOCAxNjo0NCwgYnJpYW4gbS4g
Y2FybHNvbiB3cm90ZToKPiA+IE9uIEZyaSwgTm92IDAyLCAyMDE4IGF0IDExOjEwOjUxQU0gLTA1
MDAsIFBldGVyIEtvc3R5dWtvdiB3cm90ZToKPiA+PiBXYW50ZWQgdG8gYnJpbmcgdG8geW91ciBh
dHRlbnRpb24gYW4gaXNzdWUgdGhhdCB3ZSBkaXNjb3ZlcmVkIG9uIG91cgo+ID4+IFdpbmRvd3Mg
SmVua2lucyBub2RlcyB3aXRoIGdpdCBzY20gaW5zdGFsbGVkIChnaXQuZXhlKS4gT3VyIEplbmtp
bnMKPiA+PiBzZXJ2ZXJzIGRvbid0IGhhdmUgSW50ZXJuZXQgYWNjZXNzLiBJdCBhcHBlYXJzIHRo
YXQgZ2l0LmV4ZSBpcyB0cnlpbmcKPiA+PiB0byBjb25uZWN0IHRvIHZhcmlvdXMgQ2xvdWRmbGFy
ZSBhbmQgQWthbWFpIENETiBpbnN0YW5jZXMgb3ZlciB0aGUKPiA+PiBJbnRlcm5ldCB3aGVuIGl0
IGZpcnN0IHJ1bnMgYW5kIGl0IGtlZXBzIHRyeWluZyB0byBjb25uZWN0IHRvIHRoZXNlCj4gPj4g
Q0ROcyBldmVyeSBnaXQuZXhlIGV4ZWN1dGlvbiB1bnRpbCBpdCBtYWtlcyBhIHN1Y2Nlc3NmdWwg
YXR0ZW1wdC4gU2VlCj4gPj4gdGhlIHNjcmVlbnNob3QgYXR0YWNoZWQgd2l0aCB0aGUgZGV0YWls
cy4KPiA+Pgo+ID4+IEVuYWJsaW5nIEludGVybmV0IGFjY2VzcyB2aWEgcHJveHkgZml4ZXMgdGhl
IGlzc3VlIGFuZCBnaXQuZXhlCj4gPj4gY29udGludWVzIHRvIHdvcmsgZmFzdCBvbiB0aGUgbmV4
dCBhdHRlbXB0cyB0byBydW4gZ2l0LmV4ZQo+ID4+Cj4gPj4gSXMgdGhlcmUgYW55IGNvbmZpZ3Vy
YXRpb24gc2V0dGluZyB0aGF0IGNhbiBkaXNhYmxlIHRoaXMgZ2l0J3MKPiA+PiBiZWhhdmlvciBv
ciBpcyB0aGVyZSBhbnkgb3RoZXIgd29ya2Fyb3VuZCB3aXRob3V0IGFsbG93aW5nIEludGVybmV0
Cj4gPj4gYWNjZXNzPyBPdGhlcndpc2UsIGV2ZXJ5IGdpdCBjb21tYW5kIHJ1biBvbiBhIHNlcnZl
ciB3aXRob3V0IHRoZQo+ID4+IEludGVybmV0IHRha2VzIGFib3V0IDMwIHNlY29uZHMgdG8gY29t
cGxldGUuCj4gPgo+ID4gR2l0IGl0c2VsZiBkb2Vzbid0IG1ha2UgYW55IGF0dGVtcHQgdG8gYWNj
ZXNzIHRob3NlIHN5c3RlbXMgdW5sZXNzIGl0J3MKPiA+IGNvbmZpZ3VyZWQgdG8gZG8gc28gKGUu
Zy4gYSByZW1vdGUgaXMgc2V0IHVwIHRvIHRhbGsgdG8gdGhvc2Ugc3lzdGVtcwo+ID4gYW5kIGZl
dGNoIG9yIHB1bGwgaXMgdXNlZCkuCj4gPgo+ID4gSXQncyBwb3NzaWJsZSB0aGF0IHlvdSdyZSB1
c2luZyBhIGRpc3RyaWJ1dGlvbiBwYWNrYWdlIHRoYXQgcGVyZm9ybXMKPiA+IHRoaXMgYmVoYXZp
b3IsIHNheSwgdG8gY2hlY2sgZm9yIHVwZGF0ZXMuICBJJ2QgcmVjb21tZW5kIHRoYXQgeW91Cj4g
PiBjb250YWN0IHRoZSBkaXN0cmlidXRvciwgd2hpY2ggaW4gdGhpcyBjYXNlIG1pZ2h0IGJlIEdp
dCBmb3IgV2luZG93cywKPiA+IGFuZCBzZWUgaWYgdGhleSBjYW4gdGVsbCB5b3UgbW9yZSBhYm91
dCB3aGF0J3MgZ29pbmcgb24uICBUaGUgVVJMIGZvcgo+ID4gdGhhdCBwcm9qZWN0IGlzIGF0IGh0
dHBzOi8vZ2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3MvZ2l0Lgo+ID4KPgo+IFRoZSBub3JtYWwg
R2l0IGZvciBXaW5kb3dzIGluc3RhbGwgaW5jbHVkZXMgYW4gb3B0aW9uIHRvIGNoZWNrIGZvcgo+
IHVwZGF0ZXMgYXQgYSBzdWl0YWJsZSByYXRlLiBNYXliZSB5b3UgYXJlIGhpdHRpbmcgdGhhdC4g
SXQgY2FuIGJlCj4gc3dpdGNoZWQgb2ZmLgo+Cj4gLS0KPiBQaGlsaXAKQ09ORklERU5USUFMSVRZ
IE5PVElDRToKVGhpcyBpcyBhIHRyYW5zbWlzc2lvbiBmcm9tIEtvaGwncyBEZXBhcnRtZW50IFN0
b3JlcywgSW5jLgphbmQgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gd2hpY2ggaXMgY29uZmlkZW50
aWFsIGFuZCBwcm9wcmlldGFyeS4KSWYgeW91IGFyZSBub3QgdGhlIGFkZHJlc3NlZSwgYW55IGRp
c2Nsb3N1cmUsIGNvcHlpbmcgb3IgZGlzdHJpYnV0aW9uIG9yIHVzZSBvZiB0aGUgY29udGVudHMg
b2YgdGhpcyBtZXNzYWdlIGlzIGV4cHJlc3NseSBwcm9oaWJpdGVkLgpJZiB5b3UgaGF2ZSByZWNl
aXZlZCB0aGlzIHRyYW5zbWlzc2lvbiBpbiBlcnJvciwgcGxlYXNlIGRlc3Ryb3kgaXQgYW5kIG5v
dGlmeSB1cyBpbW1lZGlhdGVseSBhdCAyNjItNzAzLTcwMDAuCgpDQVVUSU9OOgpJbnRlcm5ldCBh
bmQgZS1tYWlsIGNvbW11bmljYXRpb25zIGFyZSBLb2hsJ3MgcHJvcGVydHkgYW5kIEtvaGwncyBy
ZXNlcnZlcyB0aGUgcmlnaHQgdG8gcmV0cmlldmUgYW5kIHJlYWQgYW55IG1lc3NhZ2UgY3JlYXRl
ZCwgc2VudCBhbmQgcmVjZWl2ZWQuIEtvaGwncyByZXNlcnZlcyB0aGUgcmlnaHQgdG8gbW9uaXRv
ciBtZXNzYWdlcyBieSBhdXRob3JpemVkIEtvaGwncyBBc3NvY2lhdGVzIGF0IGFueSB0aW1lCndp
dGhvdXQgYW55IGZ1cnRoZXIgY29uc2VudC4K

