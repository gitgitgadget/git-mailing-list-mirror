Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7530F556
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682813; cv=fail; b=Ek8Tk1F78sIoohKB2Qp/P3dmp8jV5DWU9MLBb7Vk5ewac3O9z4vnGiTuLZYUGH6eMzU6vh/ajmP8WXi/8l9akLBfRI54Iymox8hMEkNiheKjAKbGaCbA35ApV6LDX2FBfQuOwQX2ucEGUSYqTOWq0Wmj5FlGTBgmeYY+THbtWvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682813; c=relaxed/simple;
	bh=2MLjJ+O9BkDbhh4f40FsLUckFrQ6fZrlj7DmiLC2hTI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vd9sNKTjGn0RFIUfFhH1Ba7bF5YOI0Z1wrElwIl20ZBQQPthYYBuPKwb1b4NsDap6AVsMmHnPFEheOpSXuNS3TJHgenWdvZJhxidtX2FiR6RRfAxg+YMJNNBrt8o5y3kIavrcJHCsH2gr9vhB/SVteevpUn8QLwxcC8nHOY1wF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nk1MLtEl; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nk1MLtEl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhCl5PtlIZj5i677SbGEjOl73MLmxq+LLW0U3Rv5sgsJ31CD4Nu28QZjJEQNPG90TdmPh3HYli1xMuUxPjWzHHWEdjXIJWa+VCrM+vOAxiAAblZVDm/ZpQ3apewex58Dm1ZPpUl0tjzFrzRF4ZrxrEMuz5skveKCd8xrDg5/V5I1sWC+rnSow8ZvdrqIt8AlCdyXJp44eQY7NSJxWqmRZUA0VQ23ymkwanAuiN3QVa4+Has40Uj9KpqzYwtAqtOdcrcFchM4hFkQKddt5KAVaTitSWTC/a13JEiWAHtKO5ADrMgNJUt6uyTrr4CjhvwUiE7PbCyBbU9FptdPE3Cdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MLjJ+O9BkDbhh4f40FsLUckFrQ6fZrlj7DmiLC2hTI=;
 b=vPXBCWwZMpKBLiPB6tZxC1bjlevGl3j/tu3MRjk1F3cLObrfsr9jkH+rtpmUyxrPS0QzN2Yr6D/hLmcVElhur3sxeqhdX7trn4WOdMIVCr/qk244sek6VlPNaOD4OkdnVeR76nzU/fqorGEECabAyXDLFDmBonPy4K7ZsYTUUvJutWwbXMzBRHPFbu0S6oaDDA36tJ1ZvrnT1Md6LSmO/zGO+SLbZ3cNfnwgUsXRhB34/X+4RIUP4yLhgdRXf1aYoPC7nC6l7fBgVlkBqnkHUUycaWVIkOkXHg41+IkS0l1ufo1jUayM2tMSZkcfnncZHzT5CtH0PbQc6ITB7HqhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MLjJ+O9BkDbhh4f40FsLUckFrQ6fZrlj7DmiLC2hTI=;
 b=nk1MLtEle/Wx0bPvCtJ4DAcCdi7Xtd5Ch8WK8hcg7ctJQZQIAi1MtlIKZlzCXlWL1RudBIljfPXbCnY/3JmizhH8IRUyAcjMh+POXhduxFMCDkjkvU6DMe795RxBRhrOKsrOdJbi9QntkMHR0yTGczJw89GPEGAhFSbtj7FLF7sahUUSLVBDlUye1WpZ3eFLp6f2o2E3vSzja21EW3KD6zCryN3V74qpC/wjlrFTp7KFptCk8NVfQLe5Q4SL4qtyYVCCMlx0zKhHsMuIUL6RxOLGwT855QGF2dSLI/1nVaNp8ZqDMrU2riOMPMHxh7ll3vuDnBlnhzGBNrtuvG2QBQ==
Received: from SN6PR03MB4285.namprd03.prod.outlook.com (2603:10b6:805:c1::17)
 by BN5PR03MB8111.namprd03.prod.outlook.com (2603:10b6:408:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 13:13:29 +0000
Received: from SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b]) by SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b%5]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 13:13:29 +0000
From: Guo Tingsheng <CoriCraft16@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] Git merge produces inconsistent indentation in merged result
Thread-Topic: [BUG] Git merge produces inconsistent indentation in merged
 result
Thread-Index: AQHcI+b6kfsdybUToEexNnH+xRnTlg==
Date: Fri, 12 Sep 2025 13:13:29 +0000
Message-ID:
 <SN6PR03MB428572C742338251D0399FDFAE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4285:EE_|BN5PR03MB8111:EE_
x-ms-office365-filtering-correlation-id: 4d2a970d-6f79-401b-a68a-08ddf1fe2ac0
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpVAjouTXUgUPX+o0ch3BuGw7Ct7WW46FPNVXZWc+Wr4LcLr1VE7mYZ05qhE68/I4MduiJj7rM12PiN4h+i+DRO/Sd3VZccR6IxT5ZEnBbhHCmGS3Zci4kEcj5XKkjPiQ8bBWMe2OfJzEu2Yas0fiv3Dn+gf/SdZlh4/BC61QxvKgTK/1XYkTCTVb+bjvVSEpDU4+xNIE3UNz3bivP5Mru6RW4yFxcqozAoC/phViZthHktbupS78vMjbyKx9ajYLFj5/kxmhEtB3Y6Z5FN+PtXPMqnpKDv02itNHJr/KmyG7m3y7truk9Vs+DfsX6O+7nttvFokb4FWBSwAy7hby64sjpkC1SLvgNda+VWTBwSjzKO8x7q/+wpgsXWMXjwttXk3rh5cEZ8L6tFeUNhciiDmYBCasCtJeNYkPWrsj330Yf8UQAHRu05IzawViVWBOzeLzWW7Ilqwa6bdlPhNT2CZIm7sg3MAF2gR5gCGdiMl6Kh2Nek4fkKmNCf27H3lHs9lnhmYmmqXNISHeFBvJaJTAb6v/hy4rXTTpODOqybUjlMZlowCzRswmN/VX91dIUamuUDKGkw8jOgBhGeTl19G3zu9ZZBSdfHvEBI7s+DFo957EhYOHnUyFQqxcpPDz9eiYvS+y7r/FKu8s6gXhL7uLKxZ6QoWNeKj5ByQjD8giZfXdcGysrpMKEIjqVioHPioC5s+85Duq5tvH+hl/KuiE3sJXUU71uY/naS09LdnlgTKV9XBp+rl
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|15080799012|7042599007|31061999003|461199028|19110799012|8062599012|8060799015|40105399003|440099028|3412199025|102099032|3430499032;
x-microsoft-antispam-message-info:
 =?gb2312?B?bitxT0VhWkt5clZsdjNlZUtWNzhoR0xBRWFKZWUwRVl5QkVuL1UzdkNYdHh4?=
 =?gb2312?B?aXMyZDRSTzVXbncvdEhiUkRQOVl1ZFZsb2ZNempUZE1jQ3VHdDh3RitmTzFp?=
 =?gb2312?B?Qm5DYmZLSUdySmVtaXI2bWgxQWRvZ2NydHF1RGRkYTdhWHR5U3VWM2RtMHZq?=
 =?gb2312?B?aU1HUlRIY29Ba3V1MkVlcmVSQmRYZFY2blhucmVpck1HWk5MN2JGd3Q4NVZF?=
 =?gb2312?B?MkR6WHNOTGxpTEdzeTFFVEp5YzdqbkI1cEdnRFBxOUNpc1hEUlhFeGpKNkpn?=
 =?gb2312?B?cFVNTDFFUTBpa2dnL1RQenNhM2RCUFJYSmtPREpKNG4wRVpwWFNjWjEvajBw?=
 =?gb2312?B?b2oyS3RjL2wvQ21uZ1d0eEtRbHY0bVQwYnMrejdtbGVHZ3VJSUNOZ0d3Wk9N?=
 =?gb2312?B?eThLaldyM3hZZi9IbTl3aVZvL1paclNNUVB1dzA0b3NrTVhGbkZjcWNuYmhE?=
 =?gb2312?B?ZkVKd2NjbGowMHRKMnZyZmgyK2NoNXVMajcwVHlud2dEQnlyTktDbGozZXlK?=
 =?gb2312?B?cStnR0ZSeWZmMGptd29WWnl1TVJGTWlEcWl1bllTeDlmTmFKNlhUYnAzWm11?=
 =?gb2312?B?Nk8zR1pwOHlwa0ZMbmNIR0djVkNBcXBCY2pXdWNlTEhTU1ZWNW9jbEk3WTZQ?=
 =?gb2312?B?TkwyaWNCbEwyMWtDUnF2bXdyUGt1OTV1YmV4eENkQ1p6QTdLYlNSeHAzMUJy?=
 =?gb2312?B?ZmZrRUxSQkp6c1l0TUhEZUVHekhKemRKWHU0cXZJQVdSYmVhMUhnWENOV3Zz?=
 =?gb2312?B?RU1Ea3pTSVpqWmRsT0s5YWRLb2ljbnB2YnoxRFJYS2RwZmlEZkNoa29FOEQ3?=
 =?gb2312?B?dDlnMGp5R0I1dS83RkdGOHB6SWxmVm4yWUhQRHo4OThMS2pSdlVFbkJ2TGsw?=
 =?gb2312?B?Vk9IQkRXbkFxMjB6VTVvYjRFeTlhMC91UjN1WXAwaS8rdm40Z2craUF6L2lR?=
 =?gb2312?B?QnFHT2UrSkZmUEZkNzVxY0VLMFRNOEZaN2pOQ0JVL2dURE5aanUvR3dwNzRr?=
 =?gb2312?B?eElUbDRwTEVPa25uQ2hPVUFMdzlpQmJ6eGk4d1hnWXhKQmZ3MER2dTlhTDJI?=
 =?gb2312?B?R0xsMUNxY1dwYzViMkdBd0VvOWlGZDJHRmRNWEk1U0RYYm5SelNoT1hwZGdm?=
 =?gb2312?B?ekV3VnJRenBYaWVoOUVkWkJzVkd1WEZlUmo5aERWOWJRUmtRZk5BTWYyRDZa?=
 =?gb2312?B?YkhWbU9PSEZQcHZZUkJrenE2K2wrZk5DSHNJeEJ0RjR6OTVKT3grc0NNK0Vw?=
 =?gb2312?B?RmY5K29BSFZDZnQrUEtzT25HMFpmYVVYcFJ4V0h2V0lwWlhtNDdIdkoyeXpI?=
 =?gb2312?B?UWZjNVlxbnlIN2doZmo4WVU5WkZ6cy9vL3BDeGZ0OEhxdm1pcDk3dldqSkFk?=
 =?gb2312?B?anB5OVJjSFlTbFgvaVhzL01jYWdqT0xZdmZXUTA1RjZBbkVCZ1VmSWFCM1Q4?=
 =?gb2312?B?Ym1IeFpwUXZLNGhscGEvNDEwY3JvbUhjM0svMXdvVVB1SGNNNS9VaERtNVZT?=
 =?gb2312?B?V1ZpcE9lZHlYaTRTeDRJMUtMTHI2L0g5OHRKMVFEWjE2M0pXSjJGNGoxb2ZC?=
 =?gb2312?B?S055ZmFjYnVCb0k3bW5xczl1WEJKMXNsNXFKYnlVY1A2YzdSVmhEQjVXMGh4?=
 =?gb2312?B?TGI4QmQrQ0hJajFMYzFwcVJqNXBBY2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bjZ0MEdOZWU3bStVTGdzN1pENndLREM0ZnJPczQydU9OQTBGZ2lMSDdtd1dJ?=
 =?gb2312?B?ZkdtRi9qNWpjMWZVMnFYM3liRFZrT3dSenhyempsMjc5S2Eza3R6VUN5eWFS?=
 =?gb2312?B?bWxyK1F5SFZjWFREc1J6eGpvVVRITHg5VElQcFNMOUl5Vk40akRMd1RzemNq?=
 =?gb2312?B?RFhUTDAxemxzdnprM1JsRzNCTUVBK1dMRW43SUpWNThoUTRaMC9pM3MrSE9Y?=
 =?gb2312?B?WkJOVEk4MUxGdjRaSXFINlRmSU5wa3ZFZlVHWWw4STBmSlNIMjkzK2JKSU9M?=
 =?gb2312?B?MDJBbjRsSUJDOGFST1dBN1VHbWZ3eWhIMmg1ZXVRbER5dlExUXJQMXBSMCtQ?=
 =?gb2312?B?eHAvNTVuRWVXUXZxVUw1Q2R6T25LejBlTmNmNm1hV0luUW1xMXRYOXY2OW8r?=
 =?gb2312?B?b0J6enVsQURDaUhXdkpwc2tqOE9NMDRQbWxEVFVDWWNOYkFXNlU3bk5QSHd0?=
 =?gb2312?B?enUyWGFhRVdicHNIdEFBR05JbkxjUXhmdEdPN05ENWJPdGFmVmhtK2JkYmc3?=
 =?gb2312?B?WGFYaTJMWlp1b0YwRGdGNjhiQjlCSUVzL0l5S3pXa20yaFdZWkRxb0xtNkJi?=
 =?gb2312?B?NHRiK296bTcwM3d5QlZrRWlDdHZ2Zlc3Um1KMnpuM3EzVnJoVEpNT1FQNG9R?=
 =?gb2312?B?USswV1lXSkc1UzVUT09URzI5Y3JQRVU1L2l1TFVmK1o5UnI0U3o1cityekdl?=
 =?gb2312?B?Qm1NRzZsd2ZyVHJPN3hiTVVFWXovSXUwSjB4RnVTRnBsTDZyd1hvN2k3bU9u?=
 =?gb2312?B?cUJpOW42VmNmNi9UeGtGRkNkVWx1bFBJcVFiVU1TOTB6QTZ6R1g2VkV2MXVn?=
 =?gb2312?B?b3U0Q1NZOVkzcTdyQzEzU3JBWi9KbUc3RjVvbm1qNzhod3c3UDNscmxWakZB?=
 =?gb2312?B?d0RQZGdSK2xzT1lpdGprVDhjQ3gvSUtUZEUxelBjVkVJVmZKUkJKaU5HZHI5?=
 =?gb2312?B?c1N6VmRDRWpKbXlNR1prWElNMEZZZTI3QzgxSzVCcElZRCtpYkxQUlV4bjhI?=
 =?gb2312?B?WjRGWlhwaXpwWXlYOW8yNGR4NVNVYmhvTXM5YmtMMUEvb3RvdUh1OUJwc2d5?=
 =?gb2312?B?ckdQcGtLOVhQcUtPMklvY1pkOXJqUjJLN09PcTB0ZEVLMWhpaS8zQy9FTFN3?=
 =?gb2312?B?Mkg2K2lsampyM3RNT3B1c2poSW10Ykk0Ukd0YlZZTm5SUzVQSGFoWU5HY2tt?=
 =?gb2312?B?Q2pSTU1sL3QycjkwK003MGlpV1UxYks3c2lkKzNHbStsRVJCWktvYjlEUC8y?=
 =?gb2312?B?RGhRMnRMem9hWjEwRDlmL1lvRzJhQmczTmpIT0w1TDB3WCtjSUVzUXJZM1By?=
 =?gb2312?B?MndEbW1XR0o5eHB0cVZPNzZDamR5UnVOL1NpUlQwSzZFYlhJZFNkY3RDWXpl?=
 =?gb2312?B?MzdHaTlvNlRTMkFRZGY5SWpxQXE5bWRISkY1bGpGRFVVWDdNZzJraGd5ZlRx?=
 =?gb2312?B?ajJ6Z1dkdDlNTUxiRXhCRjkrV1BkZzdjdlhFR2VOeUhoTHJUWWhmUE1OY0dO?=
 =?gb2312?B?Nk5tMzZYcWtxVEE5RHpBMWNJWVR6RGFTdUVzeHVaQjJOeEdCOEtQeUhsS3I2?=
 =?gb2312?B?T05tNG1HUnQxZXZScW50eVpYQUNHa3RMaE9Tbk53MnRGQ0NqblZjU0pMVkZL?=
 =?gb2312?Q?PsweOLyH0yLjNYV6j/dGgA1h3v56Lck/JbVlq7ZQxvrg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4285.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2a970d-6f79-401b-a68a-08ddf1fe2ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 13:13:29.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8111

SGVsbG8gR2l0IGRldmVsb3BlcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGEgcG90ZW50aWFs
IGZvcm1hdHRpbmcgaXNzdWUgSSBlbmNvdW50ZXJlZCB3aGVuIHRlc3RpbmcgR2l0IG1lcmdlcy4K
CkVudmlyb25tZW50OgotIGdpdCB2ZXJzaW9uOiAyLjQzLjAKLSBPUzogVWJ1bnR1IDI0LjA0IExU
UyAKClN0ZXBzIHRvIHJlcHJvZHVjZToKMS4gU3RhcnQgZnJvbSBhIGNvbW1pdCBjb250YWluaW5n
IHRoZSBmb2xsb3dpbmcgbWV0aG9kOgoKICAgcHVibGljIHZvaWQgcHJvY2VzcygpIHsKICAgICAg
IGlmIChmbGFnKSB7CiAgICAgICAgICAgZXhlY3V0ZSgpOwogICAgICAgfQogICB9CgoyLiBPbiBi
cmFuY2ggQSwgbW9kaWZ5IHRoZSBjb2RlIGJ5IGFkZGluZyBhIG5ldyBjb25kaXRpb25hbCBibG9j
ayB3aXRoIGluZGVudGF0aW9uIGNvbnNpc3RlbnQgd2l0aCB0aGUgc3Vycm91bmRpbmcgc3R5bGU6
CgogICBwdWJsaWMgdm9pZCBwcm9jZXNzKCkgewogICAgICAgaWYgKGZsYWcpIHsKICAgICAgICAg
ICBleGVjdXRlKCk7CiAgICAgICB9CiAgICAgICBpZiAoc2hvdWxkTG9nKSB7CiAgICAgICAgICAg
bG9nZ2VyLmxvZygiQWN0aW9uIGV4ZWN1dGVkLiIpOwogICAgICAgfQogICB9CgozLiBPbiBicmFu
Y2ggQiwgbWFrZSBubyBjaGFuZ2VzIHRvIHRoaXMgZnVuY3Rpb24uCgo0LiBNZXJnZSBicmFuY2gg
QSBhbmQgYnJhbmNoIEIgdXNpbmc6CiAgIGdpdCBtZXJnZSBBCgpFeHBlY3RlZCByZXN1bHQ6Ci0g
VGhlIG1lcmdlZCBmaWxlIHNob3VsZCByZXRhaW4gdGhlIGluZGVudGF0aW9uIHN0eWxlIGludHJv
ZHVjZWQgYnkgYnJhbmNoIEE6CgogICBwdWJsaWMgdm9pZCBwcm9jZXNzKCkgewogICAgICAgaWYg
KGZsYWcpIHsKICAgICAgICAgICBleGVjdXRlKCk7CiAgICAgICB9CiAgICAgICBpZiAoc2hvdWxk
TG9nKSB7CiAgICAgICAgICAgbG9nZ2VyLmxvZygiQWN0aW9uIGV4ZWN1dGVkLiIpOwogICAgICAg
fQogICB9CgpBY3R1YWwgcmVzdWx0OgotIEdpdCByZWR1Y2VzIHRoZSBpbmRlbnRhdGlvbiBvZiB0
aGUgbmV3bHkgYWRkZWQgbGluZXMsIHByb2R1Y2luZyBpbmNvbnNpc3RlbnQgZm9ybWF0dGluZzoK
CiAgIHB1YmxpYyB2b2lkIHByb2Nlc3MoKSB7CiAgICAgICBpZiAoZmxhZykgewogICAgICAgICAg
IGV4ZWN1dGUoKTsKICAgICAgIH0KICAgaWYgKHNob3VsZExvZykgewogICAgICAgbG9nZ2VyLmxv
ZygiQWN0aW9uIGV4ZWN1dGVkLiIpOwogICB9CiAgIH0KCkFkZGl0aW9uYWwgaW5mb3JtYXRpb246
Ci0gVGhpcyBpc3N1ZSBhcHBlYXJzIHRvIG9jY3VyIG5vbi1kZXRlcm1pbmlzdGljYWxseSBhY3Jv
c3MgZGlmZmVyZW50IHRlc3QgY2FzZXMuCi0gSXQgZG9lcyBub3Qgc2VlbSByZWxhdGVkIHRvIGNv
cmUud2hpdGVzcGFjZSBvciBzcGFjZS1jaGFuZ2Ugb3B0aW9ucywgYnV0IGluc3RlYWQgdG8gaG93
IEdpdCBkZWNpZGVzIGluZGVudGF0aW9uIGZvciBuZXdseSBpbnRyb2R1Y2VkIGJsb2Nrcy4KLSBU
aGUgcHJvYmxlbSB3YXMgcmVwcm9kdWNlZCB1c2luZyBtdWx0aXBsZSBtZXJnZSBzdHJhdGVnaWVz
IChvcnQsIHJlY3Vyc2l2ZSkuCgpUaGFua3MsCkNvcmk=
