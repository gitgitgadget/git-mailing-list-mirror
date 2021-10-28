Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B18FC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6D060234
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJ1IEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:04:43 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:51334
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230060AbhJ1IEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 04:04:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv9BF8hdf51I5l2k107K8y0Z36WpyA4H3ApdFyRgwK1OVndsu95mk6jX7mdgORYlZWt/R+PsuEaQ4WX2G0ZcIiuE9fVgPtrfXbZPvk2e54VJ0owKXI0ZY+3QXsZvwHCGzIVEDyk3V1LEMwUucZT287PW7hRfvZGL/cgpLu+Hqnh99zTwgG/2nYmqT0bUcs4speyQNJ3rsM0T7gFC4lJ0cZgf5np4BcV7k+S88o46QEe41+LWwnK4IDHOxj0bdV+tbZsuI8oYWB105xs401Li0ZSOoZLxuqhEYfhUiH6bml+HkrHGPxBmvT4QJihk+fEClrrsUu+tI8BnIBSrgqEVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVnOLGGCotoHzDbGOT1Q4YJPmKMqlzmv1usDa22h3Vw=;
 b=Fg9eFcGQ7GCLX1JYBu6K3H3oOWul42wgumni7/911tmaYGVUj+N4w74DBFL1CF+5LYDppms4broZUXKCq0fiN0NQzVdRlsSEu2asxkP4avPUzmfim+oKeZNFf57joIrQyorpcR3jwNYO64JHVghA2aWBWLId2i63MXEA435YtRn/+Uq/yrIY0CvFaynukVFqqpYYpG5nfjgslEQbk7O7E930hH/3s2/B5QPe/blvm53eXFi+RwXlAHTzeA8mFkdEXOQPyxwazqzo8qLltb9Yhhq59cAVmGC7efMFnxQs8K3wma4lQ7YW79zWc0NNyecYfwCHvWMCf3KJzcUhkQUjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVnOLGGCotoHzDbGOT1Q4YJPmKMqlzmv1usDa22h3Vw=;
 b=j9U92ISW00tn5d8DcfieYj10UMbT1QV7VcHJiDKXdiWV9F6nsADWKo3SX/QzwSzLEzkkPA8IQpzn/COo+ilJHk0c+pLE9XFY6kvXxI09325Ucm8yM8ZjoG0/+ZFX6/bAj3ql+/qNoGQE2T4LsJNikhGxY3WNWNlcFUbfgOSroqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 08:02:00 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 08:02:00 +0000
Message-ID: <6a8748aa-9ed9-8aec-860b-a7f9b0ce9504@gigacodes.de>
Date:   Thu, 28 Oct 2021 10:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/6] ssh signing: make verify-commit consider key
 lifetime
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20211027080616.619956-1-fs@gigacodes.de>
 <20211027080616.619956-4-fs@gigacodes.de> <xmqqsfwmus5g.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <xmqqsfwmus5g.fsf@gitster.g>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000005010803060302090605"
X-ClientProxiedBy: AM7PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM7PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:20b:100::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 28 Oct 2021 08:01:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72dc4ea-0f86-4c38-0665-08d999e9384a
X-MS-TrafficTypeDiagnostic: PAXPR10MB4857:
X-Microsoft-Antispam-PRVS: <PAXPR10MB485704EB5D5F3BC2DBE40D9BB6869@PAXPR10MB4857.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2d82HDKovqfceaodFWT+c1idudyKF/QxF0blO9DlSgjdEL0hpr52cLgtpMAVCPTYBVuhc/iIlmoGOASe6amEWit7JyFDmgfH9mzQU2BSQrqmmnvtxzuOsAWeYcZpNcb9LQqsl8xG0kwhUv7hT+noXay+BD67u+ok+A4FwLQnh/iWoFkhXHBE0ATCHHGEquQpixtbJFulNTgaSS5VmdYLa8OVf7BjvLnQU9yYQ2p9yw4Zzm0cNLuZQFeZjvez9BX/pd80PdBaAzGHxpRsaB93ilti1nw+TjUwfj04QtLgeb7kRi5oynQayHzYtOoLw1SeODAi5YpRCaYeeYfW/HhOsnuH9P6YKbnBb7W88qQ3vUihskOJPE/Li27WgYb54rlxsc6nnnvgGk1mY3ZgZ4i3zmpbwukbtxta7P/+CH/SfFwcm8/zJme7MNm0A2qSUk1BvcmfL+nAnk9BlBW+wwHmC/PRmhtN04InslGIP81Yu6yGE5LsSmjkiCCMIOfTxWt9Z7IRj3TY48y1Lit7go9yX4YybE0C0Fol3oChdQ5y6BoBEG+z4q4vbIPqS0iWnw2WD6W3cxEFHE/c9D4uAI2GhLscCXQROUtvWC/eNmyXW/OeLl+EB2qPUwoInLOVnfeObTZoZI0/sgUfBJ4WvpIjbVpUxZZdG0qYfgeVx/oCKmQfLk5J+P+NCuImSwqdW0V5krweQOHFRn3Oah3KXvtkyoDEjq1Ow9e7AA1nnHAZ/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(376002)(346002)(136003)(366004)(6666004)(235185007)(2906002)(2616005)(186003)(8936002)(31696002)(8676002)(36756003)(4326008)(38100700002)(66476007)(66556008)(508600001)(5660300002)(53546011)(66946007)(31686004)(52116002)(316002)(6916009)(33964004)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JjdFFBQk43QlJ6SlV2cDcrR1B5R1lwOGhNSXE3bDJ2a0RJVUExNlF1U3Jl?=
 =?utf-8?B?T1ljUlVzNDlncXlaamJZdno4YWcrOWVnQ1dqUkdTOENVcWVCNlBCMnM5eGI1?=
 =?utf-8?B?b3dOUmhrbGRTQ2NFL1dESUpydWFXcTRjTk9WV0M3ZER0TmVxVk1HME1TR3U3?=
 =?utf-8?B?cngrRHBkS2gwOWJhaHhVNlFpdHJzQzVhbnA4Y050N0hReWk0c3o2elc3dUpO?=
 =?utf-8?B?ZWYyWjdLa2wrY2tGbkszRlVBZnpyY29kNExxTFMvUTJYZ3F5clZQYTNnOWpD?=
 =?utf-8?B?SURzRE5BZEZqajFaODdOUXlKNEFzQ003bWh6UlQvSGd2OHJqcXBGeGxQVkV5?=
 =?utf-8?B?NlVVY2dpdVNBbXllMTIxcDgrd0RINGFDSlJvRWh4Z3lVTk9QRXpPK3BNSzhH?=
 =?utf-8?B?eTdHbGhtZjkwQ1NFSGc1YllKWENzYnl4Z0ErV040N1ZLZmNqU2NJNW9UaTFm?=
 =?utf-8?B?aXREbWVIcFpVakVNdjlxdUREaW9WMTRHTHl1UWF5UFlnWDBNenNYMWI4eUpn?=
 =?utf-8?B?aFhNMEZyQkc3eDhjNVhWQ1ppb1ZMc005VWVXRkZDNkdQNkU1MkRGRENZSmdt?=
 =?utf-8?B?ak5xOE9CZlVLSUNxazV5RGRMMmwrVnFYRzBGWFUwUXZseXY4NWtiVmlpYUIv?=
 =?utf-8?B?RGtkVG5EQ2RzZXpBVWxxeGNNRHhDQVp0c0lrTzAweGVibGhzUnJHMzlQYkdN?=
 =?utf-8?B?YlNueVVyWStKUCsvV2hWN3FOdHdwVlU1TXYyMVVqbE1SMXcyd2crVjhDV2Jq?=
 =?utf-8?B?bXRVM3RoVmg5N3VpWlBtSE9TOG5VK2NCSUt6am5YNHFpWUo2MmdpOVdYZ1NW?=
 =?utf-8?B?cHFiR24xcTEyOERqblVHbERkSk1WM1lEdTNaMGhJcDNQMkFmR3FnVWVoR3Fr?=
 =?utf-8?B?dUdQVzBRRTk5UEE1ZWF0anl1c0oyUjF1SlQ5Mk9HZ1dFQW1OWnJYOUVYUkJx?=
 =?utf-8?B?bGZkZzhXRjZsUUtsQTJ4OVNUa25jRHBBbU9Dc2V2eHNSYTlUL3Z6OXpnNTNr?=
 =?utf-8?B?YVlySUVkWnduT1dzb1dXeTNUdTdlSGV0aXNFems1SHhFSE5sOU8yVDd3aFRK?=
 =?utf-8?B?YjR1VituNFpJUm84bzNqM2xPVldBODUxS0lQcFpCUmUxcU8razZoTzFkdVA2?=
 =?utf-8?B?bHRzM0FZSUZDcXRtelNRMnRGSzhrT1hGK3dHVGU0emkzN2pyQkFreVg2WDMy?=
 =?utf-8?B?YjdjTmFtM3I0RFV4WXhNSlRWVDV3VGFpMFVZTTArbUlBaEhpa0ZrMXNXUHB3?=
 =?utf-8?B?ZlVmS20vN291Y1VIeEVYNVFXbkhLWURoYUlsVlVGVUhvOFc0QUtOTUNzVmtm?=
 =?utf-8?B?VUlJN3RqWWNURmFxQXBZQ3pVcUdLUWJmMEpKbVorUlhQSEVYa3VsamZQYmJL?=
 =?utf-8?B?RGxpM21PdEhLZUdSZ1k5QUU4UUppRXpzbVFqNmhOK29ob0F1MkZtWjBWcWN2?=
 =?utf-8?B?VWZXZ0t5L3pXUUVHTzRVaU5TMEhrV0l6SWZSYjFGczRYd2MzcG9lOFBWMWV0?=
 =?utf-8?B?R0pSNFhyY3dXeE8yaXk0RndoS2ZMSHFQSUcwc09hbjJBM01QTzdzYUtuRWhT?=
 =?utf-8?B?NHZoSm5tbGJNVXEvL2JUcHIvRkZuQnFyR2JTL3RteTlxZGRaVUszZmhkVWRF?=
 =?utf-8?B?NFo4Z0F2YkdMck9LK1F6SFZkcjl6N2I1UllWNldHOXdyR0d3T3RLY2tCMUVh?=
 =?utf-8?B?aDR2MzJvdFdSRmdNTWRRcTMvWWltNDFUUDllYmcwdllxUVpNWTNPZENTdDJP?=
 =?utf-8?B?Q1FQN3pKcnRBcURVNXpkaGhWTkdxcWVPbXBTR2dWcDh6VDFKbktMTG1ta0hw?=
 =?utf-8?B?Y2JSSmxqcDMvWVd6RmltZ1dJOW9LZGVMeTNoQmQ0TkpjUytBVEpDRVlvSFdn?=
 =?utf-8?B?WTVReWdMZnRudTB4SkR2cjI5MHFOY0JFcGZyaGNiTFVvOFVDL3FUb3VDYTRq?=
 =?utf-8?B?U0tsbTRvd3luMlg5L2ZTSFd1VGxLcmJncHptYTVsM1ppM3FXdGk4UE0xV1Y5?=
 =?utf-8?B?cTFBWkZnR0F5dk9KNWc0RUE2N0xrOXBhSjl4RmE4VWJEcThVY0JVZWI4Qlhh?=
 =?utf-8?B?L2gzR2F6Y3FXbFpmTXdQZ1dDZENtZlRZdHBSZVdkWEF3MjNSN1JaOW9Oazhr?=
 =?utf-8?B?NTlsaHBrYXJZSmpYTlM2bG04UHlmcmtHZFBWcFJqTHNzNTFUcDcwODdtdzlP?=
 =?utf-8?B?N3lPUTV3VHV3bUx1WVR1dG5IMzduNk91ZXdHWE8xQlR6YkVVa0ZZWlE4emVi?=
 =?utf-8?B?OHJHRWpiM0FzUkdpVlVQQlNYNjIyS0RlZzdJN0o3VzJ6cFhBMDhubWU3a0U0?=
 =?utf-8?B?eG9hMUlvWThIb3U0cHZDY0E4YzhVRW9XMHNQOUxSc05OMGorZlFVUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e72dc4ea-0f86-4c38-0665-08d999e9384a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 08:02:00.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY1Fp/gXaUbjISW08rfXDSS1po+aWA7xFYB+tCPZFRurydq4FbejvR/aKUsxsnJyL5hevVAWj9QXXqSVpfAUjPlQ0Gk/xg6Thz/DKdcR/jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4857
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------ms000005010803060302090605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.10.21 22:30, Junio C Hamano wrote:
> Fabian Stelzer <fs@gigacodes.de> writes:
> 
>> +static int parse_payload_metadata(struct signature_check *sigc)
>> +{
>> +	const char *ident_line = NULL;
>> +	size_t ident_len;
>> +	struct ident_split ident;
>> +	const char *signer_header;
>> +
>> +	switch(sigc->payload_type) {
>> +		case SIGNATURE_PAYLOAD_COMMIT:
>> +			signer_header = "committer";
>> +			break;
>> +		case SIGNATURE_PAYLOAD_TAG:
>> +			signer_header = "tagger";
>> +			break;
>> +		default:
>> +			/* Ignore unknown payload types */
>> +			return 0;
>> +	}
> 
> The case arms should be indented to the same level as opening
> switch().  Have SP between keyword "switch" and the expression
> the statement switches on.
> 

Thanks, will fix.

> More importantly, can you explain why it is necessary to allow
> callers to call this function with a random value in payload_type
> and have it silently succeed?  Isn't it a programming error that
> deserves a call to BUG("...")?
> 
> Thanks.
> 

Not really. I will add a BUG() to the default case and only ignore the
known cases that we don't want to handle.

Thanks

--------------ms000005010803060302090605
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
FAowggVwMIIEWKADAgECAgZIjQJd1vQwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYTAkRF
MSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYDVQQL
DBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFsUm9v
dCBDbGFzcyAyMB4XDTEyMTEyOTExMjM1NVoXDTI0MTEyOTIzNTk1OVowdTELMAkGA1UEBhMC
REUxJTAjBgNVBAoTHFQtU3lzdGVtcyBJbnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQt
U3lzdGVtcyBUcnVzdCBDZW50ZXIxHjAcBgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANEw1E1Ew+RLWrQYng5RJ7WpYkl6GgbA
cywRiVWSrA7L/kgvu13j9KmIuoFr5Ps3HSxX60WYVUFGicfnpzFke554CJ/AGD/pSmKxhPzg
0MytlS67gGr1p2TFN/vePeegzbGidDWjz+/tTXRtuo0kGrSf/FpVRjv/98LxeXp2d89P68oi
jXbYBZn3BPE8n3zbqGnwVd+jQahJS25dIHENuosJbmsi8KSd81aJwNbAWDAIV+Zi3Y4/0L3j
ujhXX63SNVK7q67Gtp8hEpOvRYtWNtXMpEw2LzPhtILmZEVd7urX3KBNQX/eZpmK/V1u7EXr
dOIJE/aK6qhnKGpOn/gSrLUCAwEAAaOCAfYwggHyMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4E
FgQUhoiTH4vrVZZl1UcBvTeMfM2ox6MwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzL
gkowEgYDVR0TAQH/BAgwBgEB/wIBADBTBgNVHSAETDBKMD4GCSsGAQQBvUcNGTAxMC8GCCsG
AQUFBwIBFiNodHRwOi8vc2JjYS50ZWxlc2VjLmRlL2Nwcy9jcHMyLnBkZjAIBgZngQwBAgIw
gfoGA1UdHwSB8jCB7zA6oDigNoY0aHR0cDovL2NybC5zYmNhLnRlbGVzZWMuZGUvcmwvR2xv
YmFsUm9vdF9DbGFzc18yLmNybDCBsKCBraCBqoaBp2xkYXA6Ly9sZGFwLnNiY2EudGVsZXNl
Yy5kZS9DTj1ULVRlbGVTZWMlMjBHbG9iYWxSb290JTIwQ2xhc3MlMjAyLE9VPVQtU3lzdGVt
cyUyMFRydXN0JTIwQ2VudGVyLE89VC1TeXN0ZW1zJTIwRW50ZXJwcmlzZSUyMFNlcnZpY2Vz
JTIwR21iSCxDPURFP0F1dGhvcml0eVJldm9jYXRpb25MaXN0MDoGCCsGAQUFBwEBBC4wLDAq
BggrBgEFBQcwAYYeaHR0cDovL29jc3AwNC50ZWxlc2VjLmRlL29jc3ByMA0GCSqGSIb3DQEB
CwUAA4IBAQCThdHrhHoZWcglgDokpbmWcQab/tYOdOBA3dXNXR0ggBlDSQ94dt4j3lzMN+2j
ynxKIQTZJZGZsT8HsmRC3BTnpY/T7a0gbXkdUiwXspLQs18wL0Q+Vu80V7aHkKm8R3WIMpM+
72lLGkowDbHnDUMBZYd8N4+bStWrUcn29ZfDHj9eFJSutg1yWfzl1xdfxOJmTtpmjSjRCtc7
tixaok7W2O+SlS1lmSRoMIqCDWLO34f//Dj1hHrOx4xxRnojKX2s9lYoAqyAi69XoEgdiGGf
Sj7/37yhZp0aAYbzHBFVy1rS/DC5FNYrCQfsauP2jVEaRClHbpeOwTHWNQj4HiRPMIIHRzCC
Bi+gAwIBAgIQGcQYOJIYjQ3VtN/uupEfjDANBgkqhkiG9w0BAQsFADB1MQswCQYDVQQGEwJE
RTElMCMGA1UEChMcVC1TeXN0ZW1zIEludGVybmF0aW9uYWwgR21iSDEfMB0GA1UECxMWVC1T
eXN0ZW1zIFRydXN0IENlbnRlcjEeMBwGA1UEAxMVVGVsZVNlYyBCdXNpbmVzcyBDQSAxMB4X
DTIwMDIxODEwNDg0NFoXDTIzMDIxODIzNTk1OVowgbgxCzAJBgNVBAYTAkRFMRQwEgYDVQQK
EwtjYW1Qb2ludCBBRzEVMBMGA1UECxMMY2FtcG9pbnQubmV0MRQwEgYDVQQLEwtFbmdpbmVl
cmluZzEXMBUGA1UEAxMORmFiaWFuIFN0ZWx6ZXIxDzANBgNVBCoTBkZhYmlhbjEQMA4GA1UE
BBMHU3RlbHplcjEeMBwGCSqGSIb3DQEJARYPZnNAZ2lnYWNvZGVzLmRlMQowCAYDVQQFEwEx
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzbHjTTbD/7OTER1JcFv2dsDtVRxg
fkbZlLqcd1u0t5W2rVt1a31rXY7smiTfy7dSbdj0mCHu0ud8WgjU/+i1NveWsmX1pKZ6hNEa
2yvTRC8DRe+U6+ba/uTbhQmEngvAU8EPHZPcGfilaGoSMot5bwh43XTe6hiPaZknZPa/6BqY
RXNaEvlJpVHC2GISNXWsARHpwXQRhd3rcqI0Y2sljnfpWbc3Aq5tydC6No0ftLGJK9Mqyqpy
B0LZQfkUeKlFMBmfPRuqQY3USQHbmte+ubSTASbOt2kmz34KzHF9Tpc659M5LMea13RKy5GT
L9gB3caeGbYHOIM6hysy+DSPLwIDAQABo4IDjTCCA4kwHwYDVR0jBBgwFoAUhoiTH4vrVZZl
1UcBvTeMfM2ox6MwHQYDVR0OBBYEFG5COl6QaEu+ziQIm+nfntcMBPfFMA4GA1UdDwEB/wQE
AwIFIDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwWAYDVR0gBFEwTzBDBgkrBgEE
Ab1HDRkwNjA0BggrBgEFBQcCARYoaHR0cDovL3NiY2EudGVsZXNlYy5kZS9kb3dubG9hZC9j
cHMyLnBkZjAIBgYEAI96AQEwCQYDVR0TBAIwADCB8AYDVR0fBIHoMIHlMD2gO6A5hjdodHRw
Oi8vY3JsLnNiY2EudGVsZXNlYy5kZS9ybC9UZWxlU2VjX0J1c2luZXNzX0NBXzEuY3JsMIGj
oIGgoIGdhoGabGRhcDovL2xkYXAuc2JjYS50ZWxlc2VjLmRlL0NOPVRlbGVTZWMlMjBCdXNp
bmVzcyUyMENBJTIwMSxPVT1ULVN5c3RlbXMlMjBUcnVzdCUyMENlbnRlcixPPVQtU3lzdGVt
cyUyMEludGVybmF0aW9uYWwlMjBHbWJILEM9REU/Q2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dDCCAScGCCsGAQUFBwEBBIIBGTCCARUwLwYIKwYBBQUHMAGGI2h0dHA6Ly9vY3NwMDMuc2Jj
YS50ZWxlc2VjLmRlL29jc3ByMEQGCCsGAQUFBzAChjhodHRwOi8vY3J0LnNiY2EudGVsZXNl
Yy5kZS9jcnQvVGVsZVNlY19CdXNpbmVzc19DQV8xLmNydDCBmwYIKwYBBQUHMAKGgY5sZGFw
Oi8vbGRhcC5zYmNhLnRlbGVzZWMuZGUvY249VGVsZVNlYyUyMEJ1c2luZXNzJTIwQ0ElMjAx
LG91PVQtU3lzdGVtcyUyMFRydXN0JTIwQ2VudGVyLG89VC1TeXN0ZW1zJTIwSW50ZXJuYXRp
b25hbCUyMEdtYkgsYz1kZT9jQUNlcnRpZmljYXRlMIGUBgNVHREEgYwwgYmBD2ZzQGdpZ2Fj
b2Rlcy5kZYEbZmFiaWFuLnN0ZWx6ZXJAZ2lnYWNvZGVzLmRlgQ9mc0BjYW1wb2ludC5uZXSB
G2ZhYmlhbi5zdGVsemVyQGNhbXBvaW50Lm5ldKArBgorBgEEAYI3FAIDoB0MG2ZhYmlhbi5z
dGVsemVyQGNhbXBvaW50Lm5ldDANBgkqhkiG9w0BAQsFAAOCAQEAA/gvcSSSg+3Fv/zQ5W8Q
NqZ7e+o2gvAAK9/m13ZZsffXma0MlVxnszHSecBWNWIGaMsnorfs3UOBtvNKi071OSZHIRdt
01R/BeIs1THloF5i93LxJht8L9YhUPLVFpLyXSJpAeZeBgmgxETjZ6NxMPvDGTowJbXuoghl
Enffv2OZ/eqyQfloJhs0GedD+ywRcHRtgdebhmdAIND+0wvEwb4orZYpVMC1Iif5YQoRoppy
KhFBXM7umYzm3a3o9F1xsdCZtH8pcsQbxk6++rFdwATjRXPdqx1nrJc/7KTPFpPiAXNLn8AE
FxntRDmy+kAHAqGOvPr7p6ZoCuLjJxc8mDCCB0cwggYvoAMCAQICECqns9Gy7hp/JP/uYPRZ
JCcwDQYJKoZIhvcNAQELBQAwdTELMAkGA1UEBhMCREUxJTAjBgNVBAoTHFQtU3lzdGVtcyBJ
bnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQtU3lzdGVtcyBUcnVzdCBDZW50ZXIxHjAc
BgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMTAeFw0yMDAyMTgxMDQ4NDRaFw0yMzAyMTgy
MzU5NTlaMIG4MQswCQYDVQQGEwJERTEUMBIGA1UEChMLY2FtUG9pbnQgQUcxFTATBgNVBAsT
DGNhbXBvaW50Lm5ldDEUMBIGA1UECxMLRW5naW5lZXJpbmcxFzAVBgNVBAMTDkZhYmlhbiBT
dGVsemVyMQ8wDQYDVQQqEwZGYWJpYW4xEDAOBgNVBAQTB1N0ZWx6ZXIxHjAcBgkqhkiG9w0B
CQEWD2ZzQGdpZ2Fjb2Rlcy5kZTEKMAgGA1UEBRMBMTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALzoNe796N6LfGhYkcCF7XtOjZiCfLDwx1L9QhDv0DwGp+dLo+5n/iI+/rlA
wwBgqhtLvaaWNE2vJuXYMVZXVyUgz4Wq1FvX9lXd7J4IiHhiHqcY1r0GB8IrY6kpiRaH5iyt
fOexvsVW9ddo3FzUGjjGMDYsyd9ppzqWXE9Q3Nbc7U9orhnGGp3xh20HTdP+iIDEaUhHkJIl
Rpni14oY+kSWq1WSw2m+qKsWux6KcQS3wKuoO3AAi5DX6vDtp5xztnffqI+SmCeT44CyCwrK
uZk5JBMsOaeaWYr8UiTNzS26Y46f2KeXnss2qc85i4p0hxp/qj7q28UwV5gE1w2La7cCAwEA
AaOCA40wggOJMB8GA1UdIwQYMBaAFIaIkx+L61WWZdVHAb03jHzNqMejMB0GA1UdDgQWBBR/
VPCB1rrm9xWvIhb2q8u5gSXriDAOBgNVHQ8BAf8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUH
AwIGCCsGAQUFBwMEMFgGA1UdIARRME8wQwYJKwYBBAG9Rw0ZMDYwNAYIKwYBBQUHAgEWKGh0
dHA6Ly9zYmNhLnRlbGVzZWMuZGUvZG93bmxvYWQvY3BzMi5wZGYwCAYGBACPegEBMAkGA1Ud
EwQCMAAwgfAGA1UdHwSB6DCB5TA9oDugOYY3aHR0cDovL2NybC5zYmNhLnRlbGVzZWMuZGUv
cmwvVGVsZVNlY19CdXNpbmVzc19DQV8xLmNybDCBo6CBoKCBnYaBmmxkYXA6Ly9sZGFwLnNi
Y2EudGVsZXNlYy5kZS9DTj1UZWxlU2VjJTIwQnVzaW5lc3MlMjBDQSUyMDEsT1U9VC1TeXN0
ZW1zJTIwVHJ1c3QlMjBDZW50ZXIsTz1ULVN5c3RlbXMlMjBJbnRlcm5hdGlvbmFsJTIwR21i
SCxDPURFP0NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwggEnBggrBgEFBQcBAQSCARkwggEV
MC8GCCsGAQUFBzABhiNodHRwOi8vb2NzcDAzLnNiY2EudGVsZXNlYy5kZS9vY3NwcjBEBggr
BgEFBQcwAoY4aHR0cDovL2NydC5zYmNhLnRlbGVzZWMuZGUvY3J0L1RlbGVTZWNfQnVzaW5l
c3NfQ0FfMS5jcnQwgZsGCCsGAQUFBzAChoGObGRhcDovL2xkYXAuc2JjYS50ZWxlc2VjLmRl
L2NuPVRlbGVTZWMlMjBCdXNpbmVzcyUyMENBJTIwMSxvdT1ULVN5c3RlbXMlMjBUcnVzdCUy
MENlbnRlcixvPVQtU3lzdGVtcyUyMEludGVybmF0aW9uYWwlMjBHbWJILGM9ZGU/Y0FDZXJ0
aWZpY2F0ZTCBlAYDVR0RBIGMMIGJgQ9mc0BnaWdhY29kZXMuZGWBG2ZhYmlhbi5zdGVsemVy
QGdpZ2Fjb2Rlcy5kZYEPZnNAY2FtcG9pbnQubmV0gRtmYWJpYW4uc3RlbHplckBjYW1wb2lu
dC5uZXSgKwYKKwYBBAGCNxQCA6AdDBtmYWJpYW4uc3RlbHplckBjYW1wb2ludC5uZXQwDQYJ
KoZIhvcNAQELBQADggEBAKhFKqWHnQ+41OcsXr/96UBOGPo5B8NT4FZy1o6QY5NVicS+y2Kz
8pOoeJbhg4nCc9FdSfYvPp6z1KboYSGusM5NNto4qdWqWDZ/+25lWrlMYsCtxKyD9Smtsu/7
uwikJ5NO8rOP08JoznvwWZ2INq+sRyJ57zwNoNVs/65v3xyYyrC+BFOAGIg3B3J1Jw2wmoM8
lDsnoGUjh7R9FstuY2CK29RaVCO2w35Vvd9cwqQzOVURq0t+2MGh0RItXH7450gfR7RZVoYG
vNTXsR6/3RzcM+YbYZMBCQuAH4ibFmIw3TjdShpjQiAfc+cCPNSbnrenvzhgKcEH4ZiOz4cS
RdQxggPMMIIDyAIBATCBiTB1MQswCQYDVQQGEwJERTElMCMGA1UEChMcVC1TeXN0ZW1zIElu
dGVybmF0aW9uYWwgR21iSDEfMB0GA1UECxMWVC1TeXN0ZW1zIFRydXN0IENlbnRlcjEeMBwG
A1UEAxMVVGVsZVNlYyBCdXNpbmVzcyBDQSAxAhAqp7PRsu4afyT/7mD0WSQnMA0GCWCGSAFl
AwQCAQUAoIICEzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0y
MTEwMjgwODAxNTZaMC8GCSqGSIb3DQEJBDEiBCC14lu5i1C5i+EeNiaSOyueHiOpT1uDe8ds
T2csBW8C2zBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCREUxJTAjBgNVBAoT
HFQtU3lzdGVtcyBJbnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQtU3lzdGVtcyBUcnVz
dCBDZW50ZXIxHjAcBgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMQIQGcQYOJIYjQ3VtN/u
upEfjDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCREUxJTAjBgNVBAoTHFQt
U3lzdGVtcyBJbnRlcm5hdGlvbmFsIEdtYkgxHzAdBgNVBAsTFlQtU3lzdGVtcyBUcnVzdCBD
ZW50ZXIxHjAcBgNVBAMTFVRlbGVTZWMgQnVzaW5lc3MgQ0EgMQIQGcQYOJIYjQ3VtN/uupEf
jDANBgkqhkiG9w0BAQEFAASCAQA3N9X60NgU+zyAzr8z1Zl2KwF29BVOboPUTTkR3EMh+Ae1
0lUA6w9jogXACNJ/tFO882j2dl/D7GXpwzdn0djLS/XMR/8yYJw3kOb5PHKrEgW7zcwo07XD
F3jFp65e2hMdUpeqAwKK2048FZbMWYbRjfdBVUd1E1WhQXdktVP0HHJw5ZxzaZwEsbR4vEqq
gNLObLBZmbopTDkoZ5VEnER/VakW7b1CS+t3XtTr1qu210kApQ7BgMHPijOoC4M3vKExmyhp
Iiocc98+hdlEjX2AJif7+MKpgk8aa4J6mIGCfYVc1ZMpnVUx70gGnnghwIPF7FjLOJzlKhWE
piFAmFPiAAAAAAAA

--------------ms000005010803060302090605--
